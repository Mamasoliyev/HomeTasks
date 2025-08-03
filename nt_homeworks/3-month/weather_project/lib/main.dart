import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_project/weather/view/screens/home_screen.dart';
import 'package:weather_project/weather/view_model/weather_provider.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider()..getCurrentWeather("Namangan"),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen()));
  }
}
