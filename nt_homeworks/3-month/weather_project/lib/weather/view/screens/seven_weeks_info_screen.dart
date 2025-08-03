import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_project/weather/view_model/weather_provider.dart';

class SevenWeeksInfoScreen extends StatefulWidget {
  String cityName;
   SevenWeeksInfoScreen({super.key, required this.cityName});

  @override
  State<SevenWeeksInfoScreen> createState() => _SevenWeeksInfoScreenState();
}

class _SevenWeeksInfoScreenState extends State<SevenWeeksInfoScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherProvider>().getWeeklyWeather('Moscow');
  }

  List<String> days = [
    "Thurthday",
    "Friday",
    "Saturday",
    "Sunday",
    "Monday",
    "Tuesday",
  ];
  List<int> gradus = [21, 24, 18, 12, 16, 18];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFCDBBE),
            Color(0xFFFCBC81),
            Color(0xFFF9B687),
            Color(0xffF9B57B),
          ],
        ),
      ),
      child: Consumer<WeatherProvider>(
        builder: (context, value, child) {
          final forecastLength =
              value.weeklyWeatherData?.forecast?.forecastday?.length ?? 0;
          log("forecast length: $forecastLength");

          final weather = List.generate(
            forecastLength,
            (index) =>
                "https:${value.weeklyWeatherData?.forecast?.forecastday?[index].day?.condition?.icon ?? ''}",
          );
          log("forecast length: $forecastLength");
          log(
            (value.weeklyWeatherData?.forecast?.forecastday?[0].date)
                .toString(),
          );

          // final weather = [
          //   "https:${value.weeklyWeatherData?.forecast?.forecastday?[0].day?.condition?.icon ?? ''}",
          //   "https:${value.weeklyWeatherData?.forecast?.forecastday?[1].day?.condition?.icon ?? ''}",
          //   "https:${value.weeklyWeatherData?.forecast?.forecastday?[2].day?.condition?.icon ?? ''}",
          //   "https:${value.weeklyWeatherData?.forecast?.forecastday?[3].day?.condition?.icon ?? ''}",
          //   "https:${value.weeklyWeatherData?.forecast?.forecastday?[4].day?.condition?.icon ?? ''}",
          //   "https:${value.weeklyWeatherData?.forecast?.forecastday?[5].day?.condition?.icon ?? ''}",
          // ];
          return Scaffold(
            backgroundColor: Colors.white.withValues(alpha: 0),
            appBar: AppBar(
              scrolledUnderElevation: 0,
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text("Next 7 Days"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 15,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0xFFFEE7D4),
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Column(
                        spacing: 25,
                        children: [
                          Row(
                            children: [
                              Text("Tomorrow"),
                              Spacer(),
                              Text(
                                value
                                        .weeklyWeatherData
                                        ?.forecast
                                        ?.forecastday?[0]
                                        .day
                                        ?.avgtempC
                                        .toString() ??
                                    '',
                              ),

                              SvgPicture.asset(
                                "assets/svgs/cloud2.svg",
                                width: width * 0.2,
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              columnTomorrowInfo(
                                width,
                                height,
                                svgPath: 'assets/svgs/barometer.svg',
                                text: "1cm",
                              ),
                              columnTomorrowInfo(
                                width,
                                height,
                                svgPath: "assets/svgs/wind.svg",
                                text: "15km/h",
                              ),
                              columnTomorrowInfo(
                                width,
                                height,
                                svgPath: "assets/svgs/humidy.svg",
                                text: "50%",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Column(
                      spacing: height * 0.02,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(forecastLength, (index) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFFFCD4AC),
                          ),
                          child: Row(
                            children: [
                              Text(
                                (value
                                            .weeklyWeatherData
                                            ?.forecast
                                            ?.forecastday?[index]
                                            .date ??
                                        days[index])
                                    .toString(),
                              ),
                              Spacer(),
                              Text(
                                "${value.weeklyWeatherData?.forecast?.forecastday?[index].day?.avgtempC ?? gradus[index]}°",
                              ),
                              Image.network(
                                weather[index],
                                height: height * 0.06,
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Column columnTomorrowInfo(
    width,
    height, {
    required String? svgPath,
    required String text,
  }) {
    return Column(
      spacing: 10,
      children: [
        Container(
          height: height * 0.05,
          width: width * 0.11,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SvgPicture.asset(svgPath!, fit: BoxFit.cover),
        ),

        Text(text),
      ],
    );
  }
}
