import 'dart:async';
import 'dart:math';

Stream<String> generatePhoneNumbers(int count) async* {
  final random = Random();

  for (int i = 0; i < count; i++) {
    String phoneNumber = '(${random.nextInt(9) + 1}'
        '${random.nextInt(10)}${random.nextInt(10)}) '
        '${random.nextInt(10)}${random.nextInt(10)}${random.nextInt(10)}-'
        '${random.nextInt(10)}${random.nextInt(10)}'
        '${random.nextInt(10)}${random.nextInt(10)}';

    await Future.delayed(Duration(seconds: 1)); // 1 soniya delay
    yield phoneNumber;
  }
}

Future<void> main() async {
  print("📱 Telefon raqamlari ro'yxati:\n");

  await for (final number in generatePhoneNumbers(10)) {
    print(number);
  }

  print("\nBarcha telefon raqamlari generatsiya qilindi.");
}
