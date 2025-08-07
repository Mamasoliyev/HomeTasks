import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_lesson/view_models/cart_controller.dart';
import 'package:getx_lesson/view_models/product_controller.dart';
import 'package:getx_lesson/views/products_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(CartController());
  Get.put(ProductController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: ProductsScreen(),
    );
  }
}
