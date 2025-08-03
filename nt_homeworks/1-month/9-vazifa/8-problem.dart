class Product {
  String name;
  double? price;
  String? manufacturer;

  Product(this.name, this.price, this.manufacturer);

  String displayInfo() {
    String priceInfo = (price != null) ? "\$${price!.toStringAsFixed(2)}" : "\$0";
    String manufacturerInfo = manufacturer ?? "Ma'lumot mavjud emas";

    return "Mahsulot nomi: $name\nNarxi: $priceInfo\nIshlab chiqaruvchi: $manufacturerInfo";
  }
}
void main() {
  Product p1 = Product("Noutbuk", 1200.0, "HP");
  print(p1.displayInfo());

  print("\n---\n");

  Product p2 = Product("Sichqoncha", null, null);
  print(p2.displayInfo());
}
