void main(List<String> args) {
  Samalyot airplane = Samalyot();
  airplane.tezlikniOshirish();
}

abstract class Transport {
  void yolovchiTashish();
  void tezlikniOshirish();
  void tezlikniKamaytirish();
}

class Avtobus extends Transport {
  @override
  void yolovchiTashish() {
    // TODO: implement yolovchiTashish
  }

  @override
  void tezlikniOshirish() {
    // TODO: implement tezlikniOshirish
  }

  @override
  void tezlikniKamaytirish() {
    // TODO: implement tezlikniKamaytirish
  }
}

class Taksi extends Transport {
  @override
  void yolovchiTashish() {
    // TODO: implement yolovchiTashish
  }

  @override
  void tezlikniOshirish() {
    // TODO: implement tezlikniOshirish
  }

  @override
  void tezlikniKamaytirish() {
    // TODO: implement tezlikniKamaytirish
  }
}

class Samalyot extends Transport {
  @override
  void yolovchiTashish() {
    // TODO: implement yolovchiTashish
  }

  @override
  void tezlikniOshirish() {
    print("Max speed: 300km/h");
  }

  @override
  void tezlikniKamaytirish() {
    // TODO: implement tezlikniKamaytirish
  }
}
