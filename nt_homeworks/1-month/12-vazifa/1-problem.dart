void main() {
  Map<String, List<String>> kurslar = {
    'English': ['Ali', 'Sami'],
    'Flutter': ['Ali', 'Asad'],
    'Math': ['Sami'],
  };

  Map<String, int> talabaKurslarSoni = {};

  kurslar.forEach((kurs, talabalar) {
    for (var talaba in talabalar) {
      if (talabaKurslarSoni.containsKey(talaba)) {
        talabaKurslarSoni[talaba] = talabaKurslarSoni[talaba]! + 1;
      } else {
        talabaKurslarSoni[talaba] = 1;
      }
    }
  });

  List<String> iqtidorlilar = talabaKurslarSoni.entries
      .where((entry) => entry.value > 1)
      .map((entry) => entry.key)
      .toList();

  print('Bir nechta kursda qatnashayotgan talabalar: $iqtidorlilar');
}
