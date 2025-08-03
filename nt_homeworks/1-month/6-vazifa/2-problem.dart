class BadiiyAsar {
  String  nom; 
  String muallif;
  String janr;

  BadiiyAsar(this.nom, this.muallif, this.janr);

  void asarningMalumotlari(){
    print("$nom muallif: $muallif, Janri:$janr");
  }
}
void main(){
  BadiiyAsar asar1 = BadiiyAsar("O'tkan kunlar", "Abdulla Qodiriy", "realistik ijtimoiy-psixologik");
  asar1.asarningMalumotlari();

  asar1.nom = "Mehrobdan chayon";
  asar1.muallif = "Cho‘lpon";
  asar1.janr = "tragik-psixologik";

  print("O'zgargan asar1 holati: ");
  asar1.asarningMalumotlari();

  BadiiyAsar asar2 = BadiiyAsar("Ikki eshik orasi", "Erkin A’zam", "psixologik-problematik");
  asar2.asarningMalumotlari();
}