// Abstrakt class
abstract class Athlete {
  int trainingHours(); // Mashq soatlari
  String perform(); // Sportdagi chiqishi yoki uslubi
}

// Futbol o‘yinchisi klassi
class FootballPlayer extends Athlete {
  int hours;
  FootballPlayer(this.hours);

  @override
  int trainingHours() {
    return hours;
  }

  @override
  String perform() {
    return 'Futbol o‘yinchisi maydonda to‘p bilan ishlaydi, tez yuguradi va gol urishga harakat qiladi.';
  }
}

class Swimmer extends Athlete {
  int hours;
  Swimmer(this.hours);

  @override
  int trainingHours() {
    return hours;
  }

  @override
  String perform() {
    return 'Suzuvchi suvda turli uslublarda suzadi, tezlik va chidamlilikni oshiradi.';
  }
}

void main() {
  Athlete player1 = FootballPlayer(5);
  Athlete swimmer1 = Swimmer(3);

  print('Futbolchi mashg‘ulot soati: ${player1.trainingHours()}');
  print('Futbolchi chiqishi: ${player1.perform()}');

  print('\nSuzuvchi mashg‘ulot soati: ${swimmer1.trainingHours()}');
  print('Suzuvchi chiqishi: ${swimmer1.perform()}');
}
