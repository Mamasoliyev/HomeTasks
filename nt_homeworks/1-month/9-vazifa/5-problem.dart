class Car {
  String model;
  String ownerName;
  int year;
  int? mileage;
  int warranty = 5;

  Car(this.model, this.ownerName, int? year, this.mileage)
      : year = year ?? 2000 {
    calculateWarranty();
  }

  void calculateWarranty() {
    if (mileage != null) {
      int reduction = mileage! ~/ 100000; // Har 100,000 km uchun 1 yil kamayadi
      warranty = (5 - reduction).clamp(0, 5); // 0 dan past tushmasligi uchun clamp
    }
  }

  String getCarDetails() {
    return '''
Avtomobil modeli: $model
Egasining ismi: $ownerName
Yili: $year
Garantiya muddati: $warranty yil
''';
  }
}
void main() {
  Car car1 = Car("Chevrolet Cobalt", "Nodirbek", 2019, 220000);
  print(car1.getCarDetails());

  Car car2 = Car("Nexia 3", "Ali", null, null);
  print(car2.getCarDetails());
}
