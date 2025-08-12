import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;

class UploadApi {
  static final String baseUrl = "https://f30d9e0882b2.ngrok-free.app";
  static final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  static Future<Response> uploadSingle(File file) async {
    final form = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: p.basename(file.path),
      ),
    });
    return _dio.post('/upload', data: form);
  }

  static Future<Response> uploadMultiple(List<File> files) async {
    final form = FormData();
    for (final f in files) {
      form.files.add(
        MapEntry(
          'files',
          await MultipartFile.fromFile(f.path, filename: p.basename(f.path)),
        ),
      );
    }
    return _dio.post('/upload', data: form);
  }

  static Future<Response> listFiles() => _dio.get('/files');

  static Future<Response> deleteFile(String filename) =>
      _dio.delete('/files/$filename');

  static Future<void> downloadFile(
    String url,
    String savePath,
    void Function(int, int) onProgress,
  ) async {
    await _dio.download(url, savePath, onReceiveProgress: onProgress);
  }
}
