import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductRemoteDataSource {
  final client = http.Client();

  /// Barcha mavjud kategoriyalarni olib keladi
  Future<List<String>> getAllCategories() async {
    final response = await client.get(
      Uri.parse('https://fakestoreapi.com/products/categories'),
    );

    if (response.statusCode == 200) {
      return List<String>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load categories');
    }
  }

  /// Kategoriya bo‘yicha yoki 'all' bo‘lsa barcha mahsulotlarni olib keladi
  Future<List<Map<String, dynamic>>> getProductsByCategory(
    String category,
  ) async {
    final String url = category == 'all'
        ? 'https://fakestoreapi.com/products'
        : 'https://fakestoreapi.com/products/category/${Uri.encodeComponent(category)}';

    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load products for category $category');
    }
  }
}
