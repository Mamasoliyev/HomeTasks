import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:getx_darsi/model/product_model..dart';

class ProductServices extends GetxService {
  Dio dio;

  ProductServices({required this.dio});

  Future<List<ProductModel>> fetchProducts() async {
    final url = "https://api.escuelajs.co/api/v1/products";

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        log("status kod 200 ifdan otdie");
        final List<ProductModel> products = (response.data as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
        return products;
      } else {
        log("ifdan otmadi otmadi ${response.statusCode}");
        throw Exception("malumot yuklashda xatolik mavjud !!!");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
