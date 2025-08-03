void main() {
  Map<String, Set<String>> kategoriyalar = {
    'Fantastika': {'Dunyo Urushi', 'Yulduzlar Sarguzashti'},
    'Tarix': {'Dunyo Urushi', 'Boburnoma'},
    'Sarguzasht': {'Yulduzlar Sarguzashti', 'Qora Qalpoq'},
  };

  Map<String, int> kitoblarKategoriyalarSoni = {};

  kategoriyalar.forEach((kategoriya, kitoblar) {
    for (var kitob in kitoblar) {
      kitoblarKategoriyalarSoni[kitob] = (kitoblarKategoriyalarSoni[kitob] ?? 0) + 1;
    }
  });

  List<String> birNechtaKategoriyaKitoblar = kitoblarKategoriyalarSoni.entries
      .where((entry) => entry.value > 1)
      .map((entry) => entry.key)
      .toList();

  print('Bir nechta kategoriyada mavjud kitoblar: $birNechtaKategoriyaKitoblar');
}
