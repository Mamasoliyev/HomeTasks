import 'package:flutter/material.dart';
import 'package:stateless_widget/screens/weather_screen.dart';

void main(List<String> args) {
  runApp(StatelessWidgetApp());
}

class StatelessWidgetApp extends StatelessWidget {
  const StatelessWidgetApp({super.key});
  // annotatsiya
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
    );
  }
}
