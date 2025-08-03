class Kafedra {
  String nom;
  String manzil;
  int mijozlarSoni;

  Kafedra(this.nom, this.manzil, this.mijozlarSoni);

  void mijozQosh() {
    mijozlarSoni += 1;
  }

  void kafedraMalumotlari() {
    print('Kafedra nomi: "$nom", Manzil: "$manzil", Mijozlar soni: $mijozlarSoni');
  }
}

void main() {
  var kafedra1 = Kafedra("Informatika", "TUIT, 3-bino", 5);
  kafedra1.kafedraMalumotlari();

  kafedra1.mijozQosh();
  kafedra1.mijozQosh();

  kafedra1.kafedraMalumotlari();
}
