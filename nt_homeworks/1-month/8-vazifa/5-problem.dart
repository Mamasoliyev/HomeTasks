class TolovPlatformasi {
  static final TolovPlatformasi _instance = TolovPlatformasi._ichki();
  double balans = 0;
  static int tolovlarSoni = 0;

  TolovPlatformasi._ichki();

  static TolovPlatformasi get instance => _instance;

  void tolovYubor(double summa) {
    double yakuniySumma = summa + (summa * 0.02);
    balans += yakuniySumma;
    tolovlarSoni++;
  }

  void info() {
    print("Balans: $balans, To'lovlar soni: $tolovlarSoni");
  }
}

void main() {
  var platforma = TolovPlatformasi.instance;

  platforma.tolovYubor(100000);
  platforma.tolovYubor(50000);

  platforma.info();
}
