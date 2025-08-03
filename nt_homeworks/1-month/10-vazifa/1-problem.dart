class ShoppingCart {
  List<String>? items; 

  void addProduct(String product) {
    
    (items ??= [])
      ..add(product) 
      ..forEach((item) => print('Qo‘shildi: $item'));
  }
}

void main() {
  var cart = ShoppingCart();

  cart.addProduct('Olma');
  cart.addProduct('Banan');
  cart.addProduct('Uzum');
}
