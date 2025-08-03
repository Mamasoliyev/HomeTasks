import 'package:flutter/material.dart';
import 'package:stateless_widget/widgets/weather_widgets.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildLocationWidget(),
              const SizedBox(height: 20),
              buildTodayWeatherInfo(),
              const SizedBox(height: 20),
              buildForecastList(),
            ],
          ),
        ),
      ),
    );
  }
}
