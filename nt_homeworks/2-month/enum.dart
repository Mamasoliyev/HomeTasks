enum Rang {
  Qizil,
  Yashil,
  Kok
}

void main() {
  Rang tanlanganRang = Rang.Yashil;

  switch (tanlanganRang) {
    case Rang.Qizil:
      print('Qizil rang tanlandi.');
      break;
    case Rang.Yashil:
      print('Yashil rang tanlandi.');
      break;
    case Rang.Kok:
      print('Ko\'k rang tanlandi.');
      break;
  }
  var enum_qiymatlari = Rang.values;

  // har bir qiymatni chiqarish
  for (var rang in Rang.values) {
    print(rang);
  }

  // qizil rang name ishlatmasdan olamiz
  print(Rang.Qizil);

  // name orqali
  print(Rang.Qizil.name);

  print(Rang.Qizil.index); // 0
  print(Rang.Yashil.index); // 1
  print(Rang.Kok.index); // 2

  void rangniChopEt(Rang rang) {
    print('Tanlangan rang: $rang');
  }

  rangniChopEt(Rang.Qizil);
}