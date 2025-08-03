import 'dart:async';

Future<String> telefonBuyurtmaQilish() async {
  await Future.delayed(Duration(seconds: 5));
  return "Telefon buyurtma qilindi";
}

Future<String> kompyuterBuyurtmaQilish() async {
  await Future.delayed(Duration(seconds: 7));
  return "Laptop buyurtma qilindi";
}

void main() async {
  print("Buyurtmalar jo'natildi...");

  List<String> natijalar = await Future.wait([
    telefonBuyurtmaQilish(),
    kompyuterBuyurtmaQilish(),
  ]);

  for (var xabar in natijalar) {
    print(xabar);
  }
}
