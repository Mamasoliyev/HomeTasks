mixin NarxOptimallashtir {
  List<double> narxniOzgartir(List<double> narxlar, bool oshirish) {
    return narxlar.map((narx) {
      return oshirish ? narx * 1.1 : narx * 0.9;
    }).toList();
  }
}

class Mahsulot with NarxOptimallashtir {}

void main() {
  var mahsulot = Mahsulot();
  var narxlar = [100.0, 200.0, 300.0];

  var yangilanganNarxlar = mahsulot.narxniOzgartir(narxlar, false);

  print("10% pasaytirilgan narxlar: $yangilanganNarxlar");
}
