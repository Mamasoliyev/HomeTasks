import 'package:dio/dio.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:getx_darsi/services/product_services.dart';
import 'package:getx_darsi/viev_model/card_controller.dart';
import 'package:getx_darsi/viev_model/getx_controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Dio());
    Get.lazyPut(() => ProductServices(dio: Get.find()));
    Get.lazyPut(() => ProductController(productServices: Get.find()));
    Get.lazyPut(() => CardController());
  }
}
