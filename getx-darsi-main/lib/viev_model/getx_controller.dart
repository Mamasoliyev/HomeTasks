import 'package:get/get.dart';
import 'package:getx_darsi/model/product_model..dart';
import 'package:getx_darsi/services/product_services.dart';

class ProductController extends GetxController {
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxBool isLoading = false.obs;
  RxString errorText = "".obs;

  final ProductServices productServices;

  ProductController({required this.productServices});

  Future<void> getProducts() async {
    try {
      isLoading.value = true;
      final productsData = await productServices.fetchProducts();

      products.addAll(productsData);
    } catch (e) {
      errorText.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await getProducts();
  }
}
