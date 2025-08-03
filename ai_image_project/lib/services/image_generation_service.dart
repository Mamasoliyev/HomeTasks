import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saver_gallery/saver_gallery.dart';

class ImageGenerationService {
  Dio dio = Dio();

  final url = "https://image.pollinations.ai/prompt";

  Future<File?> generateImage(String prompt) async {
    final appDir = await getDownloadsDirectory();
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    final filePath = '${appDir!.path}/$fileName';
    try {
      final result = await dio.get(
        "$url/$prompt",
        options: Options(responseType: ResponseType.bytes),
      );

      final resultImage = await SaverGallery.saveImage(
        Uint8List.fromList(result.data),
        quality: 60,
        fileName: fileName,
        androidRelativePath: "Pictures/appName/images",
        skipIfExists: false,
      );

      final file = File(filePath);
      file.writeAsBytes(result.data);

      return file;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
