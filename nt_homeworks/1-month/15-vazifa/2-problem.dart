abstract class Employee {
  void work();
  void takeBreak();
}

class Manager extends Employee {
  @override
  void work() {
    print("Menejer reja tuzadi va xodimlarga vazifa taqsimlaydi.");
  }

  @override
  void takeBreak() {
    print("Menejer tanaffus paytida kofe ichadi va qisqa dam oladi.");
  }
}

class Developer extends Employee {
  @override
  void work() {
    print("Dasturchi kod yozadi, xatolarni tuzatadi va test qiladi.");
  }

  @override
  void takeBreak() {
    print("Dasturchi tanaffusda ko‘zlarini dam oldiradi va choy ichadi.");
  }
}

void main() {
  Employee manager = Manager();
  Employee developer = Developer();

  manager.work();
  manager.takeBreak();

  developer.work();
  developer.takeBreak();
}
