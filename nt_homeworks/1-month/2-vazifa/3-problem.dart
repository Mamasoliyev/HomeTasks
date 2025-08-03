import 'dart:io';

void main() {
  int yili = int.parse(stdin.readLineSync() ?? "0");
  double sugurta;
  if (yili <= 3) {
    sugurta = yili / 100 * 5;
  } else if (yili > 3 && yili < 10) {
    sugurta = yili / 100 * 8;
  } else {
    sugurta = yili / 100 * 12;
  }

  print("Sug'urta summasi: $sugurta");
}
