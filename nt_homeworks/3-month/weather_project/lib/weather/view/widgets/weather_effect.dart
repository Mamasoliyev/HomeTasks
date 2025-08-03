import 'package:flutter/material.dart';
import 'package:weather_project/core/app/custom_paints/sun_painter.dart';
import 'package:weather_project/weather/view/animations/cloudy_painter.dart';
import 'package:weather_project/weather/view/animations/snow_animation.dart';
import 'package:weather_project/weather/view/screens/weather_animation_screen.dart';

class WeatherEffect extends StatelessWidget {
  final String condition;

  const WeatherEffect({super.key, required this.condition});

  @override
  Widget build(BuildContext context) {
    switch (condition.toLowerCase()) {
      case 'rain':
        return const RainAnimation();
      case 'clear':
      case 'sunny':
        return const SunPainterWidget();
      case 'snow':
        return const SnowAnimation();
      default:
        return  CloudyPainterWidget();
    }
  }
}
