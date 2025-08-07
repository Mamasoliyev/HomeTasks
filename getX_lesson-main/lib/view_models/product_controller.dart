import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';

class ProductController extends GetxController {
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      error('');

      final dio = Dio();
      final response = await dio.get('https://api.escuelajs.co/api/v1/products');

      if (response.statusCode == 200) {
        // response.data is already a List<dynamic> due to dio's JSON parsing
        final List<dynamic> rawList = response.data as List<dynamic>;
        products.assignAll(rawList.map((json) => ProductModel.fromJson(json as Map<String, dynamic>)).toList());
      } else {
        error('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      error('Error fetching products: $e');
    } finally {
      isLoading(false);
    }
  }
}