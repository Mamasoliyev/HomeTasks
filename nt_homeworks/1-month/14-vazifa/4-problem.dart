void main() {
  Mushuk mushuk = Mushuk("Moshkina", "Mushuk", 2, "Uy", true);
  mushuk.eat();
  mushuk.sleep();
  mushuk.purr();

  print('---');

  It it = It("Buron", "It", 3, "Bog'", "nemischa");
  it.eat();
  it.bark();

  print('---');

  Qush qush = Qush("Qaldirg'och", "Qush", 1, "Daraxt", true);
  qush.sleep();
  qush.fly();

  print('---');

  YirtqichHayvon sher =
      YirtqichHayvon("Sher", "Yirtqich", 5, "Savanna", "Go‘sht");
  sher.eat();
  sher.hunt();
}
class Hayvon {
  String ism;
  String turi;
  int yosh;
  String yashashJoy;

  Hayvon(this.ism, this.turi, this.yosh, this.yashashJoy);

  void eat() {
    print("$ism ovqatlanmoqda.");
  }

  void sleep() {
    print("$ism uxlamoqda.");
  }
}
class Mushuk extends Hayvon {
  bool yumshoqTuyuq;

  Mushuk(
      String ism, String turi, int yosh, String yashashJoy, this.yumshoqTuyuq)
      : super(ism, turi, yosh, yashashJoy);

  void purr() {
    print("$ism murillamoqda.");
  }
}
class It extends Hayvon {
  String zot;

  It(String ism, String turi, int yosh, String yashashJoy, this.zot)
      : super(ism, turi, yosh, yashashJoy);

  void bark() {
    print("$ism vovullamoqda.");
  }
}
class Qush extends Hayvon {
  bool uchadimi;

  Qush(String ism, String turi, int yosh, String yashashJoy, this.uchadimi)
      : super(ism, turi, yosh, yashashJoy);

  void fly() {
    if (uchadimi) {
      print("$ism uchmoqda.");
    } else {
      print("$ism ucha olmaydi.");
    }
  }
}
class YirtqichHayvon extends Hayvon {
  String oziqTuri;

  YirtqichHayvon(
      String ism, String turi, int yosh, String yashashJoy, this.oziqTuri)
      : super(ism, turi, yosh, yashashJoy);

  void hunt() {
    print("$ism yirtqichlik qilmoqda, oziq: $oziqTuri.");
  }
}
