dynamic getNum(int? num){
  return num ??  "Telefon mavjud emas";
}
void main(List<String> args) {
  print(getNum(1));
}