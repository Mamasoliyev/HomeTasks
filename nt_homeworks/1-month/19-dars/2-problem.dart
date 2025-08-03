import 'dart:async';
import 'dart:io';

Stream<String> getUserData() async* {
  final stdin = ConsoleReader();

  print('Ismingizni kiriting:');
  String name = stdin.readLineSync()?.trim() ?? 'Noma\'lum';
  yield 'Ismingiz: $name';

  print('Yoshingizni kiriting:');
  String ageInput = stdin.readLineSync()?.trim() ?? '0';
  int age = int.tryParse(ageInput) ?? 0;
  yield 'Yoshingiz: $age';
}

void main() async {
  print('Ma\'lumotlaringizni kiriting:');

  await for (final data in getUserData()) {
    print(data);
  }

  print('Rahmat! Ma\'lumotlaringiz qabul qilindi.');
}

class ConsoleReader {
  String? readLineSync() {
    return stdin.readLineSync();
  }
}
