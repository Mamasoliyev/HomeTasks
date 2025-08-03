import 'package:flutter/material.dart';
import 'package:weather_project/core/app/extensions/string_extension.dart';
import 'package:weather_project/weather/models/current_weather_model.dart';
import 'package:weather_project/weather/models/hourly_weather_model.dart';
import 'package:weather_project/weather/models/weekly_weather_model.dart';
import 'package:weather_project/weather/services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  bool isLoading = false;
  CurrentWeatherModel? currentWeatherData;
  WeeklyWeatherModel? weeklyWeatherData;
  String errorMessage = "";
  String errorHourlyMessage = "";

  String weatherCondition = "";
  HourlyWeatherModel? hourlyWeatherModel;
  List<HourlyCurrent> get hourlyList =>
      hourlyWeatherModel?.forecast.forecastday[0].hour ?? [];

  bool isHourlyLoading = false;

  Future<HourlyWeatherModel?> getHourlyWeather(String cityName) async {
    try {
      isHourlyLoading = true;
      final result = await WeatherService.fetchHourlyWeather(cityName);
      hourlyWeatherModel = result;
      errorHourlyMessage = "";
      return result;
    } catch (e) {
      errorHourlyMessage = e.toString();
      hourlyWeatherModel = null;
      return null;
    } finally {
      isHourlyLoading = false;
      notifyListeners(); // Notify end of loading
    }
  }

  // get current weather
  Future<void> getCurrentWeather(String cityName) async {
    isLoading = true;
    try {
      final result = await WeatherService.fetchCurrentWeather(
        cityName: cityName,
      );
      currentWeatherData = result;
      weatherCondition = result.current.condition.text.toWeatherCondition();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getWeeklyWeather(String cityName) async {
    // isLoading = true;
    try {
      final result = await WeatherService.weeklyWeather(cityName);
      weeklyWeatherData = result;
    weatherCondition =  result.current?.condition?.text != null ?  result.current!.condition!.text!.toWeatherCondition()  : '';
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
