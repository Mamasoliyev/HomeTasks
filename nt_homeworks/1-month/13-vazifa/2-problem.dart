void main(List<String> args) {
  
  List<double> prices = [200, 550, 700, 300, 800];

  prices = prices.where((element) => element > 500,).toList();
  print(prices);

  print(prices.reduce((value, element) {
    return value + element;
  },)~/prices.length);

}