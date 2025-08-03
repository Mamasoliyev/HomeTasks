class Dokon {
  Map<String, int> mahsulotlar = {
    'non': 3000,
    'sut': 5000,
    'yog\'': 20000,
    'choy': 10000,
  };

  int umumiyNarx(List<String> buyurtma) {
    return buyurtma.fold(0, (sum, item) => sum + (mahsulotlar[item] ?? 0));
  }
}

void main() {
  Dokon dokon = Dokon();

  Map<String, List<String>> mijozBuyurtmalari = {
    'Ali': ['non', 'sut', 'choy'],
    'Vali': ['yog\'', 'non'],
    'Salim': ['choy', 'choy', 'non'],
  };

  mijozBuyurtmalari.forEach((mijoz, buyurtma) {
    int narx = dokon.umumiyNarx(buyurtma);
    print('$mijoz buyurtmasi narxi: $narx so\'m');
  });
}
