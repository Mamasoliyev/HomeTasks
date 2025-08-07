import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/cart_item.dart';
import '../models/product_model.dart';

class CartController extends GetxController {
  final RxList<CartItem> _cartItems = <CartItem>[].obs;
  final _storage = GetStorage();
  static const String _cartKey = 'cart_items';

  CartController() {
    _loadCart();
  }

  List<CartItem> get cartItems => _cartItems.toList();

  double get totalPrice => _cartItems.fold(
    0,
        (sum, item) => sum + (item.product.price * item.quantity),
  );

  void _loadCart() {
    final List<dynamic>? savedItems = _storage.read(_cartKey);
    if (savedItems != null) {
      _cartItems.addAll(
        savedItems.map((item) => CartItem.fromJson(item)).toList(),
      );
    }
  }

  void _saveCart() {
    _storage.write(_cartKey, _cartItems.map((item) => item.toJson()).toList());
  }

  void addToCart(ProductModel product) {
    final existingItem = _cartItems.firstWhereOrNull(
          (item) => item.product.id == product.id,
    );

    if (existingItem == null) {
      _cartItems.add(CartItem(product: product));
    } else {
      existingItem.quantity++;
      _cartItems.refresh();
    }

    _saveCart();
  }

  void incrementQuantity(int productId) {
    final item = _cartItems.firstWhere((item) => item.product.id == productId);
    item.quantity++;
    _saveCart();
    _cartItems.refresh();
  }

  void decrementQuantity(int productId) {
    final item = _cartItems.firstWhere((item) => item.product.id == productId);
    item.quantity--;
    if (item.quantity <= 0) {
      _cartItems.remove(item);
    }
    _saveCart();
    _cartItems.refresh();
  }

  void removeFromCart(int productId) {
    _cartItems.removeWhere((item) => item.product.id == productId);
    _saveCart();
  }
}