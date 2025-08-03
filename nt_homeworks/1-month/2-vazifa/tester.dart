void main(List<String> args) {
  String? dataChecker(String? data){
    print(data ?? "Ma'lumot mavjud emas");
  }
  dataChecker('\'\'');
  dataChecker(null);


  double? calculateDiscountPrice(double? price,double ? chegirma){
   print(((price ?? 0)*(1-(chegirma ??0)/100)));
  }
  calculateDiscountPrice(100, 10);
  calculateDiscountPrice(null, null);


  List? calculateAveragePrice(List<String?>? oylik) {
    //print(oylik.isNotEmpty ? oylik : 0.0);
    print(oylik?.isNotEmpty);
  }

  calculateAveragePrice([null]);
}