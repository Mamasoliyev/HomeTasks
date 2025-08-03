class Taom {
  String nom;
  double narx;
  int kaloriyalar;

  Taom(this.nom, this.narx, this.kaloriyalar);

  void taomMalumotlari() {
    print("Taom: $nom, Narx: $narx so'm, Kaloriyalar: $kaloriyalar");
  }
}

class Restoran {
  List<Taom> taomlar = [];

  void taomQosh(Taom taom) {
    taomlar.add(taom);
  }

  void restoranTaomlari() {
    print("Restorandagi taomlar:");
    for (var taom in taomlar) {
      taom.taomMalumotlari();
    }
  }
}

void main() {
  Restoran restoran = Restoran();

  Taom taom1 = Taom("Osh", 30000, 800);
  Taom taom2 = Taom("Hotdog", 15000, 500);
  Taom taom3 = Taom("Suzma", 12000, 200);

  restoran.taomQosh(taom1);
  restoran.taomQosh(taom2);
  restoran.taomQosh(taom3);

  restoran.restoranTaomlari();
}
