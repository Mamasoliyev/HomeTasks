mixin YetkazibBerish {
  double masofagaQarabNarx(double km, double narxPerKm) {
    return km * narxPerKm;
  }

  double yetkazishVaqti(double km, double tezlik) {
    return km / tezlik;
  }

  double ogirlikNarxi(double ogirlik, double narxPerKg) {
    return ogirlik * narxPerKg;
  }
}

class Buyurtma with YetkazibBerish {
  double ogirlik;
  double masofa;
  double tezlik;
  double narxPerKm;
  double narxPerKg;

  Buyurtma({
    required this.ogirlik,
    required this.masofa,
    required this.tezlik,
    required this.narxPerKm,
    required this.narxPerKg,
  });

  void hisobla() {
    double masofaNarxi = masofagaQarabNarx(masofa, narxPerKm);
    double ogirlikTolovi = ogirlikNarxi(ogirlik, narxPerKg);
    double vaqt = yetkazishVaqti(masofa, tezlik);
    double umumiyNarx = masofaNarxi + ogirlikTolovi;

    print("Masofaga qarab narx: ${masofaNarxi.toStringAsFixed(0)} so‘m");
    print("Og‘irlik uchun narx: ${ogirlikTolovi.toStringAsFixed(0)} so‘m");
    print("Umumiy narx: ${umumiyNarx.toStringAsFixed(0)} so‘m");
    print("Yetkazib berish vaqti: ${vaqt.toStringAsFixed(1)} soat");
  }
}

void main() {
  var buyurtma = Buyurtma(
    ogirlik: 10,
    masofa: 120,
    tezlik: 60,
    narxPerKm: 1000,
    narxPerKg: 2000,
  );

  buyurtma.hisobla();
}
