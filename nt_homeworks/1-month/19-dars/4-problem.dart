import 'dart:async';

Stream<String> generateTemperatures() async* {
  final temperatures = ['25°C', '26°C', '27°C'];
  for (final temp in temperatures) {
    yield temp;
    await Future.delayed(const Duration(seconds: 1));
  }
}

Stream<String> generateHumidityLevels() async* {
  final humidityLevels = ['50%', '55%', '60%'];
  for (final humidity in humidityLevels) {
    yield humidity;
    await Future.delayed(const Duration(seconds: 1));
  }
}

Stream<String> generatePressures() async* {
  final pressures = ['1012 hPa', '1013 hPa', '1011 hPa'];
  for (final pressure in pressures) {
    yield pressure;
    await Future.delayed(const Duration(seconds: 1));
  }
}

Future<void> readWithAwaitFor() async {
  print('await for usuli bilan o\'qish:');

  print('Haroratlar:');
  await for (final temp in generateTemperatures()) {
    print(temp);
  }

  print('Namlik darajalari:');
  await for (final humidity in generateHumidityLevels()) {
    print(humidity);
  }

  print('Bosimlar:');
  await for (final pressure in generatePressures()) {
    print(pressure);
  }
}

void readWithListen() {
  print('\nlisten usuli bilan tinglash:');

  print('Haroratlar:');
  generateTemperatures().listen((temp) {
    print(temp);
  });

  print('Namlik darajalari:');
  generateHumidityLevels().listen((humidity) {
    print(humidity);
  });

  print('Bosimlar:');
  generatePressures().listen((pressure) {
    print(pressure);
  });
}

void main() async {
  // await for usuli
  await readWithAwaitFor();

  // listen usuli
  readWithListen();
}
