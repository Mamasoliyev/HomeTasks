mixin AvtoHisobla {
  double yoqilgiSarfi(double km, double litr) {
    return litr / km;
  }

  double xarajatHisobla(double km, double narx, double sarf) {
    return km * sarf * narx;
  }
}

class Avtomobil with AvtoHisobla {
  String nomi;

  Avtomobil(this.nomi);
}

void main() {
  var matiz = Avtomobil("Matiz");

  double km = 100;
  double litr = 5;
  double narx = 6000;

  double sarf = matiz.yoqilgiSarfi(km, litr); 
  double xarajat =
      matiz.xarajatHisobla(500, narx, sarf);

  print(
      "${matiz.nomi} avtomobili 500 km masofa uchun xarajati: ${xarajat.toStringAsFixed(0)} so'm");
}
