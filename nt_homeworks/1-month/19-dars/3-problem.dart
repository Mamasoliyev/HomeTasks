import 'dart:async';
import 'dart:math';

Stream<String> generateUserRegistration() async* {
  final List<String> users = ['Ali', 'Vali', 'Sara', 'Oya', 'Javlon'];
  final Random random = Random();

  while (true) {
    final String selectedUser = users[random.nextInt(users.length)];

    yield "Foydalanuvchi ro'yxatdan o'tdi: $selectedUser";

    await Future.delayed(const Duration(seconds: 2));
  }
}

Future<void> main() async {
  final stream = generateUserRegistration().take(5);

  await for (final message in stream) {
    print(message);
  }
}
