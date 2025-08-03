class Xodim {
  String ism;
  int oylikMaosh;
  int ishTajribasi;

  Xodim(this.ism, this.oylikMaosh, this.ishTajribasi);

  Xodim.yangiXodim(this.ism)
      : oylikMaosh = 1000000,
        ishTajribasi = 1;

  int bonusHisobla() {
    return (oylikMaosh * 0.1 * ishTajribasi).toInt();
  }

  void xodimMalumotlari() {
    print('Xodimning ismi: "$ism", Oylik maoshi: $oylikMaosh, Ish tajribasi: $ishTajribasi yil');
    print('Bonus: ${bonusHisobla()} so\'m');
  }
}

void main() {
  var xodim1 = Xodim("Azizbek", 1200000, 3);
  xodim1.xodimMalumotlari();

  var xodim2 = Xodim.yangiXodim("Dilshod");
  xodim2.xodimMalumotlari();
}
