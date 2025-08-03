abstract class RestaurantItem {
  String itemName();
  double itemPrice();
}

abstract class Food extends RestaurantItem {
  String name;
  double price;

  Food(this.name, this.price);
}

abstract class Beverage extends RestaurantItem {
  String name;
  double price;
  String storagePeriod;

  Beverage(this.name, this.price, this.storagePeriod);
}

class Pizza extends Food {
  Pizza(String name, double price) : super(name, price);

  @override
  String itemName() => name;

  @override
  double itemPrice() => price;
}

class Plov extends Food {
  Plov(String name, double price) : super(name, price);

  @override
  String itemName() => name;

  @override
  double itemPrice() => price;
}

class Cola extends Beverage {
  Cola(String name, double price, String storagePeriod)
      : super(name, price, storagePeriod);

  @override
  String itemName() => name;

  @override
  double itemPrice() => price;
}

class Tea extends Beverage {
  Tea(String name, double price, String storagePeriod)
      : super(name, price, storagePeriod);

  @override
  String itemName() => name;

  @override
  double itemPrice() => price;
}

void main() {
  Food pizza = Pizza("Pepperoni Pizza", 75000);
  Food plov = Plov("Farg'ona Plovi", 55000);

  Beverage cola = Cola("Coca-Cola", 10000, "6 oy");
  Beverage tea = Tea("Ko'k choy", 5000, "2 oy");

  print("Ovqatlar:");
  print("${pizza.itemName()} - ${pizza.itemPrice()} so'm");
  print("${plov.itemName()} - ${plov.itemPrice()} so'm");

  print("\nIchimliklar:");
  print("${cola.itemName()} - ${cola.itemPrice()} so'm");
  print("${tea.itemName()} - ${tea.itemPrice()} so'm");
}
