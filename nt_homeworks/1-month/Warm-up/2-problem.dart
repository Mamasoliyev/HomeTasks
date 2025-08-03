void main(List<String> args) {
  KreditKarta vscard = KreditKarta();

  vscard.balansniTekshirish();
  vscard.checkLimit(10000);
}

abstract class BankKarta {
  void tolovQilish();
  void balansniTekshirish();
}

class KreditKarta extends BankKarta {
  @override
  void tolovQilish() {
    // TODO: implement tolovQilish
  }
  @override
  void balansniTekshirish() {
    print("Puliz yo'q jigar ");
  }

  void checkLimit(double summa) {
    print(summa*1.2);
  }
}

class DebitKarta extends BankKarta {
  @override
  void tolovQilish() {
    // TODO: implement tolovQilish
  }
  @override
  void balansniTekshirish() {
    // TODO: implement balansniTekshirish
  }
}

class VisualKarta extends BankKarta {
  @override
  void tolovQilish() {
    // TODO: implement tolovQilish
  }
  @override
  void balansniTekshirish() {
    print("Puliz yo'q jigar ");
  }
}
