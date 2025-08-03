class Order {
  int orderId;
  String productName;
  int? quantity;
  double? productPrice;
  double? discount;
  double totalPrice = 0;

  Order(this.orderId, this.productName, this.quantity, this.productPrice, this.discount) {
    calculateTotalPrice();
  }

  void calculateTotalPrice() {
    if (quantity != null && productPrice != null && (discount != null || discount != 0 )) {
      totalPrice = quantity! * productPrice!;
    } else {
      totalPrice = 0;
    }
  }

  double applyDiscount() {
    if (discount != null) {
      double discountAmount = totalPrice * (discount! / 100);
      return totalPrice - discountAmount;
    } else {
      return totalPrice;
    }
  }
}

void main() {
  Order order1 = Order(1, "Laptop", 2, 1500.0, 10.0);
  print("Buyurtma summasi (chegirma bilan): ${order1.applyDiscount()}");

  Order order2 = Order(2, "Telefon", null, 800.0, null);
  print("Buyurtma summasi (chegirmasiz): ${order2.applyDiscount()}");
}
