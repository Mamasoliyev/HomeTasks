void main() {
  Map<String, Map<String, int>> baholar = {
    'Sunnat': {'Matematika': 92, 'Ingliz tili': 90, 'Fizika': 78},
    'Vali': {'Matematika': 92, 'Ingliz tili': 88, 'Fizika': 80},
    'Sarvinoz': {'Matematika': 75, 'Ingliz tili': 85, 'Fizika': 82},
    'Dono': {'Matematika': 100, 'Ingliz tili': 90, 'Fizika': 95},
  };

  Map<String, List<int>> fanBaholari = {};

  baholar.forEach((oquvchi, fanlar) {
    fanlar.forEach((fan, baho) {
      fanBaholari.putIfAbsent(fan, () => []).add(baho);
    });
  });

  fanBaholari.forEach((fan, baholar) {
    baholar.sort();
    print('$fan: Eng past baho: ${baholar.first}, Eng yuqori baho: ${baholar.last}');
  });

  Map<String, double> oquvchiOrtacha = {};

  baholar.forEach((oquvchi, fanlar) {
    double ortacha = fanlar.values.reduce((a, b) => a + b) / fanlar.length;
    oquvchiOrtacha[oquvchi] = ortacha;
  });

  List<MapEntry<String, double>> saralanganOquvchilar = oquvchiOrtacha.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  print('\nO\'rtacha bahoga qarab saralangan o\'quvchilar:');
  for (var entry in saralanganOquvchilar) {
    print('${entry.key}: ${entry.value.toStringAsFixed(2)}');
  }
}
