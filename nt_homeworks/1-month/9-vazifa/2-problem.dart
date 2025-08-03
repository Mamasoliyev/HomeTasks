dynamic chegirma(int? discountPercentage){
  return discountPercentage ?? 5;
}
void main(List<String> args) {
  print(chegirma(null));
}