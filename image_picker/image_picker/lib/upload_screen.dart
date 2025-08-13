import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:image_picker_app/permission_service.dart';
import 'upload_api.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  List<String> files = [];
  List<Map<String, dynamic>> filesInfo = [];
  bool loading = false;
  Map<String, int> downloadProgress = {};

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  Future<void> _loadFiles() async {
    setState(() => loading = true);
    try {
      final response = await UploadApi.listFiles();
      final data = response.data;

      if (data is Map && data['files'] is List) {
        filesInfo = List<Map<String, dynamic>>.from(data['files']);
        files = filesInfo
            .map<String>((file) => file['filename'].toString())
            .toList();
      } else {
        files = [];
        filesInfo = [];
      }
    } catch (e, st) {
      log("Fayllarni olishda xatolik: $e\n$st");
      files = [];
      filesInfo = [];
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Fayllarni yuklashda xatolik yuz berdi"),
          ),
        );
      }
    } finally {
      setState(() => loading = false);
    }
  }

  Future<void> _uploadSingle() async {
    // permission: Android -> storage, iOS -> photos
    final ok = await PermissionService.requestStoragePermission();
    if (!ok) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Storage ruxsati berilmadi")),
        );
      }
      return;
    }

    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    if (result == null || result.files.single.path == null) return;
    final file = File(result.files.single.path!);

    try {
      setState(() => loading = true);
      final res = await UploadApi.uploadSingle(file);
      // optional: check status code or response
      await _loadFiles();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Fayl muvaffaqiyatli yuklandi")),
        );
      }
    } catch (e, st) {
      log("Yuklashda xato: $e\n$st");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Faylni yuklashda xatolik yuz berdi")),
        );
      }
    } finally {
      setState(() => loading = false);
    }
  }

  Future<void> _uploadMultiple() async {
    final ok = await PermissionService.requestStoragePermission();
    if (!ok) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Storage ruxsati berilmadi")),
        );
      }
      return;
    }

    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );
    if (result == null || result.files.isEmpty) return;

    final selectedFiles = result.paths
        .whereType<String>()
        .map((p) => File(p))
        .toList();

    try {
      setState(() => loading = true);
      await UploadApi.uploadMultiple(selectedFiles);
      await _loadFiles();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Fayllar muvaffaqiyatli yuklandi")),
        );
      }
    } catch (e, st) {
      log("Yuklashda xato: $e\n$st");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Fayllarni yuklashda xatolik yuz berdi"),
          ),
        );
      }
    } finally {
      setState(() => loading = false);
    }
  }

  String prepareUrl(String? rawUrl, String filename) {
    if (rawUrl != null) {
      var url = rawUrl;
      if (!url.startsWith('http')) {
        url = url.startsWith('/') ? url.substring(1) : url;
        return Uri.parse(UploadApi.baseUrl).resolve(url).toString();
      }
      return url;
    }
    return Uri.parse(UploadApi.baseUrl).resolve('files/$filename').toString();
  }

  Widget _buildFileCard(String filename) {
    Map<String, dynamic>? fileInfo;
    try {
      fileInfo = filesInfo.firstWhere((f) => f['filename'] == filename);
    } catch (_) {
      fileInfo = null;
    }

    final url = prepareUrl(fileInfo?['url'], filename);
    final progress = downloadProgress[filename];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: CachedNetworkImage(
                imageUrl: url,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator.adaptive()),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.broken_image, size: 48, color: Colors.red),
                ),
              ),
              // Image.network(
              //   url,
              //   width: double.infinity,
              //   fit: BoxFit.cover,
              //   errorBuilder: (_, __, ___) => const Center(
              //     child: Icon(Icons.broken_image, size: 48, color: Colors.red),
              //   ),
              //   loadingBuilder: (context, child, loadingProgress) {
              //     if (loadingProgress == null) return child;
              //     return const Center(child: CircularProgressIndicator());
              //   },
              // ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [ 
                Expanded(
                  child: Text(
                    filename,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (progress != null)
                  SizedBox(
                    width: 60,
                    child: Text(
                      "$progress%",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
              ],
            ),
          ),
          if (progress != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: LinearProgressIndicator(
                value: (progress / 100).clamp(0.0, 1.0),
                minHeight: 6,
                backgroundColor: Colors.grey.shade200,
                color: Colors.blueAccent,
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.download_rounded, color: Colors.green),
                  onPressed: progress == null
                      ? () => _downloadFile(filename)
                      : null,
                  tooltip: "Yuklab olish",
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.redAccent,
                  ),
                  onPressed: () => _confirmDelete(filename),
                  tooltip: "O'chirish",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadFile(String filename) async {
    final ok = await PermissionService.requestStoragePermission();
    if (!ok) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Storage ruxsati berilmadi")),
        );
      }
      return;
    }

    Map<String, dynamic>? fileInfo;
    try {
      fileInfo = filesInfo.firstWhere((f) => f['filename'] == filename);
    } catch (_) {
      fileInfo = null;
    }
    final url = prepareUrl(fileInfo?['url'], filename);
    final downloadPath = await _getDownloadPath();
    final savePath = p.join(downloadPath, filename);

    downloadProgress[filename] = 0;
    setState(() {});

    try {
      await UploadApi.downloadFile(url, savePath, (received, total) {
        if (total != -1) {
          final int prog = ((received / total) * 100).floor();
          setState(() => downloadProgress[filename] = prog);
        }
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$filename muvaffaqiyatli yuklab olindi: $savePath"),
          ),
        );
      }
    } catch (e, st) {
      log("Yuklab olishda xato: $e\n$st");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Faylni yuklab olishda xatolik yuz berdi"),
          ),
        );
      }
    } finally {
      downloadProgress.remove(filename);
      setState(() {});
    }
  }

  Future<String> _getDownloadPath() async {
    if (Platform.isAndroid) {
      final dir = Directory('/storage/emulated/0/Download');
      if (await dir.exists()) return dir.path;
      // fallback: external storage directory (if path_provider used)
    } else if (Platform.isIOS) {
      // iOS: Document directory would be better (requires path_provider)
    }
    return Directory.current.path;
  }

  void _confirmDelete(String fileName) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("O‘chirishni tasdiqlang"),
        content: Text("$fileName faylini o‘chirmoqchimisiz?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Bekor"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteFile(fileName);
            },
            child: const Text("O‘chirish"),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteFile(String filename) async {
    try {
      setState(() => loading = true);
      await UploadApi.deleteFile(filename);
      await _loadFiles();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("$filename o‘chirildi")));
      }
    } catch (e, st) {
      log("O‘chirishda xato: $e\n$st");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Faylni o‘chirishda xatolik yuz berdi")),
        );
      }
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          "📂 File Upload",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : files.isEmpty
          ? const Center(
              child: Text(
                "🚫 Hozircha fayl yo‘q",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            )
          : RefreshIndicator(
              onRefresh: _loadFiles,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: GridView.builder(
                  itemCount: files.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (_, i) => _buildFileCard(files[i]),
                ),
              ),
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.file_upload),
                  label: const Text("Single"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: loading ? null : _uploadSingle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.upload_file),
                  label: const Text("Multiple"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: loading ? null : _uploadMultiple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
