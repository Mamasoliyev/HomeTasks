import 'dart:io';

void main() {
  double maosh = double.parse(stdin.readLineSync()??'0');
  double daromad = maosh < 5000000 ? maosh : (maosh >= 5000000 && maosh <= 10000000 ? (maosh - maosh / 100 * 10) : (maosh - maosh / 100 * 20));
  print(daromad);
}