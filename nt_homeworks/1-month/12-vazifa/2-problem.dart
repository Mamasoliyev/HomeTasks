void main() {
  Map<String, Set<String>> xodimlar = {
    'Ali': {'Dasturlash', 'Moliya'},
    'Olim': {'Dasturlash', 'Marketing'},
    'Nodira': {'Marketing', 'Moliya'},
    'Bekzod': {'Dasturlash'}
  };

  Map<String, int> yonalishlarSoni = {};

  xodimlar.forEach((xodim, yonalishlar) {
    for (var yonalish in yonalishlar) {
      yonalishlarSoni[yonalish] = (yonalishlarSoni[yonalish] ?? 0) + 1;
    }
  });

  yonalishlarSoni.forEach((yonalish, soni) {
    print('$yonalish: $soni ta xodim');
  });
}
