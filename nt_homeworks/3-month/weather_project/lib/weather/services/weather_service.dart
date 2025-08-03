import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:weather_project/core/constants/api_constants.dart';
import 'package:weather_project/weather/models/current_weather_model.dart';
import 'package:weather_project/weather/models/hourly_weather_model.dart';
import 'package:weather_project/weather/models/weekly_weather_model.dart';

class WeatherService {
  static Future<CurrentWeatherModel> fetchCurrentWeather({
    required String cityName,
  }) async {
    final url =
        "${ApiConstants.baseUrl}/current.json?q=$cityName&key=${ApiConstants.apiKey}";

    try {
      Response response = await get(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final payload = jsonDecode(response.body);
        return CurrentWeatherModel.fromJson(payload);
      }


      throw Exception(
        "Ma'lumot yuklashda muammo yuz berdi. ${response.statusCode}",
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  // get hourly weather
  static Future<HourlyWeatherModel> fetchHourlyWeather(String cityName) async {
    final url =
        "${ApiConstants.baseUrl}/forecast.json?key=${ApiConstants.apiKey}&q=$cityName&days=1&hourly=1";

    try {
      Response response = await get(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = HourlyWeatherModel.fromJson(jsonDecode(response.body));
        return data;
      }
      throw Exception(
        "Soatlik havo-ma'lumotlarini olishda xatolik yuz berdi, ${response.statusCode}",
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<WeeklyWeatherModel> weeklyWeather(String cityName) async {
    final url =
        "${ApiConstants.baseUrl}/forecast.json?key=${ApiConstants.apiKey}&q=$cityName&days=7";
    try {
      Response response = await get(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = WeeklyWeatherModel.fromJson(jsonDecode(response.body));
        return data;
      }
      throw Exception(
        "Haftalik havo-ma'lumotlarini olishda xatolik yuz berdi, ${response.statusCode}",
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
