class ToyPlani {
  int mehmonlarSoni;
  double byudjet;
  String joylashuv;
  static int umumiyToylar = 0;

  ToyPlani(this.mehmonlarSoni, this.byudjet, this.joylashuv) {
    if (mehmonlarSoni > 500 && byudjet < 50000000) {
      throw Exception("Mehmonlar soni 500 dan ko'p bo'lsa, byudjet kamida 50 million bo'lishi kerak");
    }
    umumiyToylar++;
  }

  void setMehmonlarSoni(int yangiSoni) {
    if (yangiSoni <= 500 || byudjet >= 50000000) {
      mehmonlarSoni = yangiSoni;
    }
  }

  void setByudjet(double yangiByudjet) {
    if (mehmonlarSoni <= 500 || yangiByudjet >= 50000000) {
      byudjet = yangiByudjet;
    }
  }

  void info() {
    print("Mehmonlar: $mehmonlarSoni, Byudjet: $byudjet, Joylashuv: $joylashuv");
  }
}

void main() {
  var toy1 = ToyPlani(400, 30000000, "Andijon");
  var toy2 = ToyPlani(550, 60000000, "Toshkent");

  toy1.setMehmonlarSoni(450);
  toy2.setByudjet(70000000);

  toy1.info();
  toy2.info();

  print("Umumiy to'ylar soni: ${ToyPlani.umumiyToylar}");
}
