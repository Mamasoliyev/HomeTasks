void main() {
  List<Map<String, dynamic>> xodimlar = [
    {'ism': 'Ali', 'maosh': 3000000},
    {'ism': 'Vali', 'maosh': 5000000},
    {'ism': 'Hasan', 'maosh': 4500000},
    {'ism': 'Sanjar', 'maosh': 2500000},
  ];

  int limit = 4000000;

  List<Map<String, dynamic>> yuqoriMaoshliXodimlar =
      xodimlar.where((xodim) => xodim['maosh'] > limit).toList();

  print('Yuqori maoshli xodimlar:');
  yuqoriMaoshliXodimlar.forEach((xodim) {
    print('${xodim['ism']} - ${xodim['maosh']} so\'m');
  });
}
