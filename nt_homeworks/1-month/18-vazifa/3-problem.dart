Future<void> tasdiqlashJarayoni() async {
  print("Buyurtma tasdiqlanmoqda...");
  await Future.delayed(Duration(seconds: 5));
  print("Buyurtma tasdiqlandi");
}

void main() async {
  await tasdiqlashJarayoni();
}
