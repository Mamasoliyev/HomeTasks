import 'dart:developer';

import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: "https://image.pollinations.ai/prompt/",
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

  Future<Response> generateImage(String prompt) async {
    try {
      final response = await dio.get(prompt); // GET for Pollinations
      log("Image generated: ${response.realUri.toString()}");
      log("Image generation response: ${response.data}");
      return response.data;
    } catch (e) {
      throw Exception("Image generation failed: $e");
    }
  }
  // file to url conversion , i get the image file from pollinations.ai and i send it to the  graphql server and it returns the url of the image, base url to get url of the image from server : http://192.168.1.38:4000/upload , it returns the url of the image, for example: {"imageUrl": "http://192.168.1.38:4000/uploads/1754509970736.png"}
  Future<Response> uploadImage(String imagePath) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imagePath, filename: 'image.png'),
      });
      final response = await dio.post('http://192.168.1.38:4000/upload', data: formData);
      log("Image upload response: ${response.data}");
      return response.data;
    } catch (e) {
      throw Exception("Image upload failed: $e");
    }
  }
}
