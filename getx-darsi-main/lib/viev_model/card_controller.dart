import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:getx_darsi/model/product_model..dart';
import 'package:get_storage/get_storage.dart';

class CardController extends GetxController {
  final RxMap<ProductModel, int> items = <ProductModel, int>{}.obs;

  final storgeKey = 'cart_iems';
  final storj = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadCartFromStorage();
  }

  //narxni xisoblash
  double get totalPrice {
    double total = 0;
    items.forEach((key, value) {
      total += (key.price ?? 0) * value;
    });
    return total;
  }

  //carga mahsulot qoshish
  void addProduct(ProductModel product) {
    if (items.containsKey(product)) {
      items[product] = items[product]! + 1;
    } else {
      items[product] = 1;
    }
    saveCartToStorage();
  }

  //mahsulotni ochirish

  void removeProduct(ProductModel product) {
    if (!items.containsKey(product)) return;
    if (items[product]! > 1) {
      items[product] = items[product]! - 1;
    } else {
      items.remove(product);
    }
    saveCartToStorage();
  }

  //mahsulotni toliq ochirish
  void removeProductCompletely(ProductModel product) {
    items.remove(product);
    saveCartToStorage();
  }

  // saqlash
  void saveCartToStorage() {
    final List<Map<String, dynamic>> storedItems = items.entries.map((entry) {
      return {'product': entry.key.toJson(), 'quantity': entry.value};
    }).toList();
    storj.write(storgeKey, storedItems);
  }

  //ovolish
  void loadCartFromStorage() {
    final storedItems = storj.read(storgeKey);
    if (storedItems != null) {
      Map<ProductModel, int> loadedItems = {};
      for (var item in storedItems) {
        var product = ProductModel.fromJson(item['product']);
        var quantity = item['quantity'] as int;
        loadedItems[product] = quantity;
      }
      items.assignAll(loadedItems);
    }
  }
}
