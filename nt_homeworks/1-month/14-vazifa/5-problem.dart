class Car {
  String marka;
  String model;
  int yil;
  String rang;
  double narx;

  Car({
    required this.marka,
    required this.model,
    required this.yil,
    required this.rang,
    required this.narx,
  });

  void startEngine() {
    print('Car is starting');
  }

  void stopEngine() {
    print('Car was stopped');
  }

  void drive() {
    print("Carni hayda");
  }

  void getDetails() {
    print(
        "Marka: $marka\nModel: $model\nYili: $yil\nRangi: $rang\nNarxi: $narx");
  }
}

class SportsCar extends Car {
  int maxSpeed;
  int acceleration;

  SportsCar(
      {required this.maxSpeed,
      required this.acceleration,
      required super.marka,
      required super.model,
      required super.yil,
      required super.rang,
      required super.narx});

  int boost({required int boostSpeed}) {
    return boostSpeed + maxSpeed;
  }

   void getSportCarDetails() {
    getDetails();
    print("Max Speed: $maxSpeed km/h");
    print("Acceleration: $acceleration m/s²");
  }
}

class Truck extends Car {
  int loadCapacity;

  Truck(
      {required this.loadCapacity,
      required super.marka,
      required super.model,
      required super.yil,
      required super.rang,
      required super.narx});
  void loadCargo() {
    print("Yuk yuklandi: ${loadCapacity}kg");
  }

  void unloadCargo() {
    if (loadCapacity > 1000) {
      print("Yukni tushirish uchun katta yuk bor, uni tushira olmaymiz.");
    } else {
      print("Yuk tushirildi: ${loadCapacity}kg");
    }
  }

  void getTruckDetails() {
    getDetails();
    print("Yuk ko'tarish quvvati: $loadCapacity tonna");
  }
}

class ElectricCar extends Car {
  double batteryCapacity;
  double chargeLevel;

  ElectricCar(
      {required this.batteryCapacity,
      required this.chargeLevel,
      required super.marka,
      required super.model,
      required super.yil,
      required super.rang,
      required super.narx});
  void recharge() {
    print("Elektr avtomobili zaryadlanmoqda...");
    chargeLevel = 100;
    print("Zaryad darajasi: $chargeLevel%");
  }

  void getElectricCarDetails() {
    getDetails();
    print("Akkumulyator sig'imi: ${batteryCapacity} kWh");
    print("Zaryad darajasi: ${chargeLevel}%");
  }
}
class CarManagementSystem {
  List<Car> cars = [];

  void addCar(Car car) {
    cars.add(car);
    print("Avtomobil tizimga qo'shildi.");
  }

  void removeCar(Car car) {
    cars.remove(car);
    print("Avtomobil tizimdan o'chirildi.");
  }

  void editCar(Car oldCar, Car newCar) {
    int index = cars.indexOf(oldCar);
    if (index != -1) {
      cars[index] = newCar;
      print("Avtomobil ma'lumotlari yangilandi.");
    }
  }

  // Sport avtomobillarini filtrlash
  List<SportsCar> getSportsCars() {
    return cars.whereType<SportsCar>().toList();
  }

  List<Truck> getTrucks() {
    return cars.whereType<Truck>().toList();
  }

  List<ElectricCar> getElectricCars() {
    return cars.whereType<ElectricCar>().toList();
  }

  void showAllCars() {
    for (var car in cars) {
      car.getDetails();
      print("\n");
    }
  }
}


void main() {
  CarManagementSystem system = CarManagementSystem();

  SportsCar sportsCar = SportsCar(
    marka: "Ferrari",
    model: "488",
    yil: 2023,
    rang: "Qizil",
    narx: 350000.00,
    maxSpeed: 350,
    acceleration: 3,
  );

  Truck truck = Truck(
    marka: "Volvo",
    model: "FH",
    yil: 2022,
    rang: "Kumush",
    narx: 90000.00,
    loadCapacity: 20,
  );

  ElectricCar electricCar = ElectricCar(
    marka: "Tesla",
    model: "Model 3",
    yil: 2021,
    rang: "Qora",
    narx: 50000.00,
    batteryCapacity: 75.0,
    chargeLevel: 80.0,
  );

  system.addCar(sportsCar);
  system.addCar(truck);
  system.addCar(electricCar);

  system.showAllCars();

  sportsCar.boost(boostSpeed: 150);

  truck.loadCargo();

  electricCar.recharge();
}
