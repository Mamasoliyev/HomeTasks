abstract class SportOyinchisi {
  String? a;
  void oyin();
}

interface class Sportchi {
  int? b;

  void jismoniyMashq() {}
}

class Shaxmatchi extends SportOyinchisi implements Sportchi {
  @override
  void oyin() {
    // TODO: implement oyin
  }

  @override
  void jismoniyMashq() {
    print('shug\'ullan atlet');
  }

  @override
  // TODO: implement a
  String? a;

  @override
  // TODO: implement b
  int? b;
}

void main(List<String> args) {
  Shaxmatchi chess = Shaxmatchi();
  chess.jismoniyMashq();
}
