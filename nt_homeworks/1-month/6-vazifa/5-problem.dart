class Futbolchi {
  String ism;
  String pozitsiya;
  int gollarSon;

  Futbolchi(this.ism, this.pozitsiya, this.gollarSon);

  void malumotlar() {
    print("Futbolchi: $ism, Pozitsiya: $pozitsiya, Gollar: $gollarSon");
  }
}

class Jamoa {
  List<Futbolchi> futbolchilar = [];

  void futbolchiQosh(Futbolchi futbolchi) {
    futbolchilar.add(futbolchi);
  }

  void engYuqoriGollar() {
    Futbolchi engYuqoriGol = futbolchilar[0];
    for (var futbolchi in futbolchilar) {
      if (futbolchi.gollarSon > engYuqoriGol.gollarSon) {
        engYuqoriGol = futbolchi;
      }
    }
    print("Eng ko'p gol urgan futbolchi: ${engYuqoriGol.ism} - ${engYuqoriGol.gollarSon} gollar.");
  }
}

void main() {
  Jamoa jamoa = Jamoa();

  Futbolchi futbolchi1 = Futbolchi("Azizbek", "Hujumchi", 12);
  Futbolchi futbolchi2 = Futbolchi("Sherzod", "Himoyachi", 5);
  Futbolchi futbolchi3 = Futbolchi("Sardor", "O'rtacha pozitsiya", 7);
  Futbolchi futbolchi4 = Futbolchi("Doston", "Darvozabon", 0);

  jamoa.futbolchiQosh(futbolchi1);
  jamoa.futbolchiQosh(futbolchi2);
  jamoa.futbolchiQosh(futbolchi3);
  jamoa.futbolchiQosh(futbolchi4);

  jamoa.engYuqoriGollar();
}
