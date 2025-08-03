class Kitob {
  String nom;
  String muallif;
  int sahifaSoni;
  static int umumiyKitoblarSoni = 0;

  Kitob(this.nom, this.muallif, this.sahifaSoni) {
    umumiyKitoblarSoni++;
  }

  void setSahifaSoni(int yangiSahifaSoni) {
    sahifaSoni = yangiSahifaSoni;
  }

  void info() {
    print("Kitob: $nom, Muallif: $muallif, Sahifa soni: $sahifaSoni");
  }
}

void main() {
  var k1 = Kitob("Alkimyogar", "Paulo Koelo", 230);
  var k2 = Kitob("Jinlar bazmi", "Tog'ay Murod", 180);

  k1.info();
  k2.setSahifaSoni(200);
  k2.info();

  print("Umumiy kitoblar soni: ${Kitob.umumiyKitoblarSoni}");
}
