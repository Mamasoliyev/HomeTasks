import 'dart:async';

Future<void> startTimer() async {
  await Future.delayed(Duration(seconds: 5));
  print('Vaqt tugadi!');
}

void main() {
  startTimer();
}
