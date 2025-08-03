void main() {
  Map<String, Set<String>> bolimlar = {
    'Mevalar': {'Olma', 'Banan', 'Uzum'},
    'Ichimliklar': {'Suv', 'Sharbat', 'Olma sharbati'},
    'Shirinliklar': {'Shokolad', 'Banan', 'Olma sharbati'},
  };

  Map<String, int> mahsulotlarBolimlarSoni = {};

  bolimlar.forEach((bolim, mahsulotlar) {
    for (var mahsulot in mahsulotlar) {
      mahsulotlarBolimlarSoni[mahsulot] = (mahsulotlarBolimlarSoni[mahsulot] ?? 0) + 1;
    }
  });

  List<String> faqatBittaBolimdagiMahsulotlar = mahsulotlarBolimlarSoni.entries
      .where((entry) => entry.value == 1)
      .map((entry) => entry.key)
      .toList();

  print('Faqat bitta bo\'limda mavjud mahsulotlar: $faqatBittaBolimdagiMahsulotlar');
}
