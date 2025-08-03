abstract class Product {
  double calculatePrice();
  String getCategory();
}


class Fruit extends Product {
  double basePrice;
  double discount;

  Fruit({required this.basePrice, required this.discount});

  @override
  double calculatePrice() {
    return basePrice - (basePrice * discount / 100);
  }

  @override
  String getCategory() {
    return "Meva";
  }
}

class Meat extends Product {
  double basePrice;
  double discount;

  Meat({required this.basePrice, required this.discount});

  @override
  double calculatePrice() {
    double discountedPrice = basePrice - (basePrice * discount / 100);
    double tax = discountedPrice * 0.05; 
    return discountedPrice + tax;
  }

  @override
  String getCategory() {
    return "Go'sht";
  }
}

void main() {
  Fruit olma = Fruit(basePrice: 15000, discount: 10);
  Meat molGoshti = Meat(basePrice: 85000, discount: 5);

  print("Mahsulot: Olma");
  print("Kategoriya: ${olma.getCategory()}");
  print("Hisoblangan narx: ${olma.calculatePrice()} so'm");

  print("\nMahsulot: Mol go'shti");
  print("Kategoriya: ${molGoshti.getCategory()}");
  print("Hisoblangan narx: ${molGoshti.calculatePrice()} so'm");
}
