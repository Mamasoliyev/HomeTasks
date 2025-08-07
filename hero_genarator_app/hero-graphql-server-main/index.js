const express = require("express");
const { graphqlHTTP } = require("express-graphql");
const { buildSchema } = require("graphql");
const multer = require("multer");
const path = require("path");
const cors = require("cors");

const app = express();
app.use(cors()); // frontendga ruxsat

// 📁 Fayl yuklash uchun sozlama
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "uploads/");
  },
  filename: (req, file, cb) => {
    const ext = path.extname(file.originalname);
    cb(null, Date.now() + ext); // Masalan: 1691171212.png
  },
});
const upload = multer({ storage });

// 🌐 Yuklangan fayllarga kirish uchun
app.use("/uploads", express.static("uploads"));

// 📤 REST orqali rasm yuklash (form-data bilan)
app.post("/upload", upload.single("image"), (req, res) => {
  if (!req.file) return res.status(400).send("No file uploaded.");
  const imageUrl = `http://192.168.1.38:4000/uploads/${req.file.filename}`;
  res.json({ imageUrl });
});

// 🧠 HAYOLIY DATABASE
let heroes = [];
let idCounter = 1;

// 📐 GraphQL schema
const schema = buildSchema(`
  type Hero {
    id: ID
    name: String
    power: String
    universe: String
    image: String
  }

  type Query {
    heroes: [Hero]
  }

  type Mutation {
    addHero(name: String!, power: String!, universe: String!, image: String!): Hero
    deleteHero(id: ID!): Hero
  }
`);

// 🔧 Resolvers (Query va Mutation funksiyalar)
const root = {
  heroes: () => heroes,

  addHero: ({ name, power, universe, image }) => {
    const newHero = {
      id: idCounter++,
      name,
      power,
      universe,
      image,
    };
    heroes.push(newHero);
    return newHero;
  },

  deleteHero: ({ id }) => {
    const index = heroes.findIndex((h) => h.id == id);
    if (index === -1) return null;
    const removed = heroes.splice(index, 1)[0];
    return removed;
  },
};

// 🚀 GraphQL endpoint
app.use(
  "/graphql",
  graphqlHTTP({
    schema,
    rootValue: root,
    graphiql: true, // Test qilish uchun brauzer UI
  })
);

// 🚀 Serverni ishga tushuramiz
app.listen(4000, () => {
  console.log("🚀 GraphQL server → http://localhost:4000/graphql");
  console.log("🖼️ Upload test → POST http://localhost:4000/upload");
});
