import 'dart:io';

void main() {
  int yosh = int.parse(stdin.readLineSync() ?? "0");
  double daromad = double.parse(stdin.readLineSync()??'0');
  String? fake_qarz = stdin.readLineSync();

  bool qarz = (fake_qarz == 'true');
  print(yosh > 25 && daromad > 5000000 && qarz == false ? "Kredit tasdiqlandi" : "Rad etildi");
}