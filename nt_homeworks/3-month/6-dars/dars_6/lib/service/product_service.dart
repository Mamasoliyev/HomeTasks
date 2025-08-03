import 'dart:convert';
import 'dart:developer';

import 'package:dars_6/model/product2_model.dart';
import 'package:dars_6/model/product_model.dart';
import 'package:http/http.dart';

class ProductService {
  static Future<List<ProductModel>> fetchProducts() async {
    final url = 'https://dummyjson.com/products';
    try {
      Response response = await get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NTAwNTcyMDEsInN1YiI6MX0.QAM9eOSrHkueWniNNV_-QoEOMLStQdTALYa1vaOvHCs',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['products'] as List<dynamic>;
        return data.map((e) => ProductModel.fromJson(e)).toList();
      }

      throw Exception('Xato bor ${response.statusCode}');
    } catch (e) {
      throw Exception(e);
    }
  }
}
