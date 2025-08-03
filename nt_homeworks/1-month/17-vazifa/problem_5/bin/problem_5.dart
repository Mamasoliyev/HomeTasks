import 'dart:async';
import 'dart:math';
import 'dart:isolate';

void computeSquare(SendPort sendPort) {
  List<int> numbers = List.generate(1000000, (index) => index + 1);
  List<int> squaredNumbers = [];

  for (var number in numbers) {
    squaredNumbers.add(number * number);
  }

  sendPort.send(squaredNumbers);
}

Future<void> main() async {
  final receivePort = ReceivePort();

  await Isolate.spawn(computeSquare, receivePort.sendPort);

  var result = await receivePort.first;

  print("First 10 squared numbers:");
  for (int i = 0; i < 10; i++) {
    print(result[i]);
  }

  receivePort.close();
}
