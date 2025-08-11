import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cat_image_model.dart';

abstract class CatImageRemoteDataSource {
  Future<CatImageModel> getRandomCatImage();
}

class CatImageRemoteDataSourceImpl implements CatImageRemoteDataSource {
  @override
  Future<CatImageModel> getRandomCatImage() async {
    final response = await http.get(Uri.parse('https://api.thecatapi.com/v1/images/search'));

    if (response.statusCode == 200) {
      final List<dynamic> decoded = json.decode(response.body);
      return CatImageModel.fromJson(decoded.first);
    } else {
      throw Exception('Failed to load image');
    }
  }
}
