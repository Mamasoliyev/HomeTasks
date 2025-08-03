import 'dart:async';

Future<String> getUserName() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Ali';
}

Future<String> getUserEmail() async {
  await Future.delayed(Duration(seconds: 3));
  return 'ali@example.com';
}

Future<String> getUserLastLogin() async {
  await Future.delayed(Duration(seconds: 1));
  return '2024-11-18 10:00:00';
}

void main() async {
  print('Maʼlumotlar olinmoqda...');

  final results = await Future.wait([
    getUserName(),
    getUserEmail(),
    getUserLastLogin(),
  ]);

  print('Maʼlumotlar tayyor:');
  print('Name: ${results[0]}');
  print('Email: ${results[1]}');
  print('Last Login: ${results[2]}');
}