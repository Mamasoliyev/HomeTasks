class Kitob {
  String nom;
  String muallif;
  int sahifalarSoni;

  Kitob(this.nom, this.muallif, this.sahifalarSoni);

  Kitob.qisqaKitob(this.nom, this.muallif) : sahifalarSoni = 99;

  void kitobMalumotlari() {
    print('Kitob nomi: "$nom", Muallif: "$muallif", Sahifalar soni: $sahifalarSoni');
  }
}

void main() {
  var kitob1 = Kitob("Matematika", "Islomov", 120);
  kitob1.kitobMalumotlari();

  var kitob2 = Kitob.qisqaKitob("She'rlar to'plami", "Aliyev");
  kitob2.kitobMalumotlari();
}