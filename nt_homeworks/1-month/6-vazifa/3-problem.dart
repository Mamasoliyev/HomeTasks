class Talaba {
  String ism;
  int yosh;
  String kurs;

  Talaba(this.ism, this.yosh, this.kurs);

  void talabaMalumotlari() {
    print("Ism: $ism, Yosh: $yosh, Kurs: $kurs");
  }

  static talabalarSoniniTopish(List<Talaba> talabalar) {
    return talabalar.length;
  }
}

void main() {
  Talaba t1 = Talaba("Nodirbek", 22, "Flutter Bootcamp");
  Talaba t2 = Talaba("Akmal", 21, "Python Dasturlash");
  Talaba t3 = Talaba("Jasur", 20, "Graphic Designer");
  t1.talabaMalumotlari();
  t2.talabaMalumotlari();
  t3.talabaMalumotlari();

  List<Talaba> talabalar = [t1, t2, t3];

  int talabalarSon = Talaba.talabalarSoniniTopish(talabalar);
  print("Jami talabalar soni: $talabalarSon");
}
