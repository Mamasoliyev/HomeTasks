import 'package:dio/dio.dart';
import '../models/image_model.dart';
import '../../../../core/network/dio_client.dart';

abstract class ImageRemoteDataSource {
  Future<ImageModel> generateImage(String prompt);
}

class ImageRemoteDataSourceImpl implements ImageRemoteDataSource {
  final DioClient dioClient;
  ImageRemoteDataSourceImpl(this.dioClient);

  @override
  Future<ImageModel> generateImage(String prompt) async {
    try {
      final Response response = await dioClient.generateImage(prompt);
      // Pollinations returns image directly or URL in response
      return ImageModel(url: response.realUri.toString());
    } catch (e) {
      throw Exception('Failed to generate image: $e');
    }
  }
  Future<String> uploadImage(String imagePath) async {
    try {
      final Response response = await dioClient.uploadImage(imagePath);
      // Assuming the response contains a JSON with 'imageUrl'
      return response.data['imageUrl'] as String;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
