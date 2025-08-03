class BankHisob {
  String ism;
  double balans;
  String valyuta;
  static int umumiyHisoblar = 0;

  BankHisob(this.ism, this.balans, this.valyuta) {
    if (balans >= 5000) {
      umumiyHisoblar++;
    } else {
      throw Exception("Minimal balans 5000 dan kam bo'lmasligi kerak");
    }
  }

  void setBalans(double yangiBalans) {
    if (yangiBalans >= 5000) {
      balans = yangiBalans;
    }
  }

  void pulQoshish(double miqdor) {
    balans += miqdor;
  }

  void pulYechish(double miqdor) {
    if ((balans - miqdor) >= 5000) {
      balans -= miqdor;
    }
  }

  void info() {
    print("Ism: $ism, Balans: $balans $valyuta");
  }
}

void main() {
  var hisob1 = BankHisob("Sardor", 7000, "UZS");
  var hisob2 = BankHisob("Madina", 10000, "USD");

  hisob1.pulQoshish(3000);
  hisob1.pulYechish(2000);

  hisob1.info();
  hisob2.info();

  print("Umumiy hisoblar soni: ${BankHisob.umumiyHisoblar}");
}
