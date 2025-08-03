class MaishiyTexnika {
  String tur;
  double kunlikEnergSarfi;
  int ishKunlarSoni;

  MaishiyTexnika(this.tur, this.kunlikEnergSarfi, this.ishKunlarSoni);

  MaishiyTexnika.energiyaTejamkor(this.tur)
      : kunlikEnergSarfi = 2.0,
        ishKunlarSoni = 25;

  double oylikEnergSarfi() {
    return kunlikEnergSarfi * ishKunlarSoni;
  }

  void texnikaMalumotlari() {
    print('Jihoz turi: "$tur", Kunlik energiya sarfi: ${kunlikEnergSarfi} kVt/soat, Ish kunlari: $ishKunlarSoni kun');
    print('Oylik energiya sarfi: ${oylikEnergSarfi()} kVt');
  }
}

void main() {
  var texnika1 = MaishiyTexnika("Kir yuvish mashinasi", 2.5, 30);
  texnika1.texnikaMalumotlari();

  var texnika2 = MaishiyTexnika.energiyaTejamkor("Muzlatgich");
  texnika2.texnikaMalumotlari();
}
