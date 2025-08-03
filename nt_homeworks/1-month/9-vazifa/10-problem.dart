class Order {
  String productName;
  double price;
  double? discount;

  Order(this.productName, this.price, this.discount);

  double calculateTotal() {
    double actualDiscount = discount ?? 0; 
    return price - actualDiscount;
  }
}
void main() {
  Order o1 = Order("Pizza", 45.0, 5.0);
  print("Buyurtma: ${o1.productName}, Umumiy narx: \$${o1.calculateTotal()}");

  Order o2 = Order("Burger", 30.0, null);
  print("Buyurtma: ${o2.productName}, Umumiy narx: \$${o2.calculateTotal()}");
}
