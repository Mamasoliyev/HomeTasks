void main(List<String> args) {
  List<int> ballar = [40, 50, 60, 70, 80];

  print("Max ball: ${ballar.reduce(
    (value, element) => value > element ? value : element,
  )}");

  print("Min ball: ${ballar.reduce(
    (value, element) => value < element ? value : element,
  )}");

  double average = ballar.reduce((a, b) => a + b) / ballar.length;

  var pastBall = [];
  var yuqoriBall = [];
  ballar.forEach((element) {
    (element < average ? pastBall : yuqoriBall).add(element);
  });

  print(pastBall);
  print(yuqoriBall);
}
