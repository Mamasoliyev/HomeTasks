class Smartfon {
  String nom;
  String brend;
  double narx;
  static int umumiySoni = 0;

  Smartfon(this.nom, this.brend, this.narx) {
    umumiySoni++;
  }

  void setNom(String yangiNom) {
    nom = yangiNom;
  }

  void setBrend(String yangiBrend) {
    brend = yangiBrend;
  }

  void setNarx(double yangiNarx) {
    narx = yangiNarx;
  }

  void info() {
    print("Nomi: $nom, Brendi: $brend, Narxi: \$${narx.toStringAsFixed(2)}");
  }
}

void main() {
  var tel1 = Smartfon("Galaxy S23", "Samsung", 999.99);
  var tel2 = Smartfon("iPhone 14", "Apple", 1199.99);

  tel1.info();
  tel2.info();

  print("Umumiy yaratilgan smartfonlar soni: ${Smartfon.umumiySoni}");
}
