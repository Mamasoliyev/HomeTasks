// server.js
require('dotenv').config();
const path = require('path');
const fs = require('fs');
const express = require('express');
const cors = require('cors');
const morgan = require('morgan');
const multer = require('multer');

const app = express();
const PORT = process.env.PORT || 4000;
const BASE_URL = process.env.BASE_URL || `http://localhost:${PORT}`;
const MAX_FILE_MB = Number(process.env.MAX_FILE_MB || 20);
const ALLOWED_MIME = (process.env.ALLOWED_MIME || '').split(',').filter(Boolean);
const UPLOAD_DIR = path.join(__dirname, 'uploads');

// ensure uploads dir exists
if (!fs.existsSync(UPLOAD_DIR)) fs.mkdirSync(UPLOAD_DIR, { recursive: true });

// middlewares
app.use(cors());
app.use(morgan('dev'));
app.use('/files', express.static(UPLOAD_DIR)); // serve files statically

// --- Multer config ---
const storage = multer.diskStorage({
  destination: (_, __, cb) => cb(null, UPLOAD_DIR),
  filename: (_, file, cb) => {
    // safe filename: timestamp-originalname (spaces->_, remove specials)
    const base = file.originalname
      .replace(/\s+/g, '_')
      .replace(/[^a-zA-Z0-9._-]/g, '');
    const name = `${Date.now()}-${base}`;
    cb(null, name);
  },
});

const upload = multer({
  storage,
  limits: { fileSize: MAX_FILE_MB * 1024 * 1024 },
  fileFilter: (_, file, cb) => {
    if (ALLOWED_MIME.length && !ALLOWED_MIME.includes(file.mimetype)) {
      return cb(new Error(`File type not allowed: ${file.mimetype}`));
    }
    cb(null, true);
  },
});

// helpers
const fileInfo = (filename) => {
  const full = path.join(UPLOAD_DIR, filename);
  const stat = fs.statSync(full);
  const mime = require('mime-types').lookup(filename) || 'application/octet-stream';
  return {
    filename,
    size: stat.size,
    uploadedAt: stat.birthtime,
    mimeType: mime,
    url: `${BASE_URL}/files/${encodeURIComponent(filename)}`,
  };
};

// routes
app.get('/', (_, res) => {
  res.json({ ok: true, message: 'File Upload API', endpoints: ['/upload', '/files'] });
});

// single OR multiple: clients can use "file" (single) or "files" (multiple)
// app.post('/upload', (req, res, next) => {
//   const multi = upload.array('files', 10);
//   const single = upload.single('file');

//   // try multi first, if no files came through, try single
//   multi(req, res, (err) => {
//     if (err && err.code !== 'LIMIT_UNEXPECTED_FILE') return next(err);
//     if (req.files && req.files.length) {
//       const list = req.files.map((f) => fileInfo(f.filename));
//       return res.status(201).json({ count: list.length, files: list });
//     }
//     single(req, res, (err2) => {
//       if (err2) return next(err2);
//       if (!req.file) return res.status(400).json({ error: 'No file provided' });
//       return res.status(201).json({ count: 1, files: [fileInfo(req.file.filename)] });
//     });
//   });
// });

// accept either "file" (single) or "files" (multiple) in one go
const acceptFileOrFiles = upload.fields([
  { name: 'file', maxCount: 1 },
  { name: 'files', maxCount: 10 },
]);

app.post('/upload', acceptFileOrFiles, (req, res) => {
  const list = [];

  if (req.files?.file?.length) {
    list.push(...req.files.file.map(f => fileInfo(f.filename)));
  }
  if (req.files?.files?.length) {
    list.push(...req.files.files.map(f => fileInfo(f.filename)));
  }

  if (!list.length) {
    return res.status(400).json({ error: 'No file provided' });
  }

  return res.status(201).json({ count: list.length, files: list });
});


app.get('/files', (_, res) => {
  const files = fs.readdirSync(UPLOAD_DIR)
    .filter((f) => fs.statSync(path.join(UPLOAD_DIR, f)).isFile())
    .map(fileInfo)
    .sort((a, b) => new Date(b.uploadedAt) - new Date(a.uploadedAt));
  res.json({ count: files.length, files });
});

app.get('/files/:filename', (req, res) => {
  const filePath = path.join(UPLOAD_DIR, req.params.filename);
  if (!fs.existsSync(filePath)) return res.status(404).json({ error: 'Not found' });
  res.sendFile(filePath);
});

app.delete('/files/:filename', (req, res) => {
  const filePath = path.join(UPLOAD_DIR, req.params.filename);
  if (!fs.existsSync(filePath)) return res.status(404).json({ error: 'Not found' });
  fs.unlinkSync(filePath);
  res.json({ ok: true, deleted: req.params.filename });
});

// central error handler
app.use((err, _req, res, _next) => {
  console.error(err);
  const status = err.message?.startsWith('File type not allowed') ? 415 : 400;
  res.status(status).json({ error: err.message || 'Upload error' });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`✅ Server running on ${BASE_URL}`);
});
