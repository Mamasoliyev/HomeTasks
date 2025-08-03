import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_project/weather/models/hourly_weather_model.dart';
import 'package:weather_project/weather/view/screens/seven_weeks_info_screen.dart';
import 'package:weather_project/weather/view/widgets/get_gradient_colors.dart';
import 'package:weather_project/weather/view/widgets/get_info_container_logo.dart';
import 'package:weather_project/weather/view/widgets/weather_effect.dart';
import 'package:weather_project/weather/view_model/weather_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedInfoCloud = 0;
  int selectedIndex = 0;
  List<String> buttons = ["Today", "Tomorrow", "Next 7 Days"];
  bool value = false;
  final cityNameController = TextEditingController();
  ValueNotifier<bool> isCloseVisible = ValueNotifier(false);
  String cityName = 'Namangan';

  @override
  void initState() {
    super.initState();
    context.read<WeatherProvider>().getCurrentWeather(cityName);
    context.read<WeatherProvider>().getHourlyWeather(cityName);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final font = width * 0.035;

    return Scaffold(
      body: Stack(
        children: [
          buildBackgroundWidget(height),

          buildWeatherEffect(),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSearchWidget(font, width),
                  buildCurrentWeather(font, height, width),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(buttons.length, (index) {
                      return TextButton(
                        onPressed: () {
                          setState(() => selectedIndex = index);
                          selectedIndex == 2
                              ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          SevenWeeksInfoScreen(cityName: cityName),
                                ),
                              )
                              : selectedIndex;
                        },
                        child: AutoSizeText(
                          buttons[index],
                          style: TextStyle(
                            fontSize: font * 1.1,
                            color:
                                selectedIndex == index
                                    ? Colors.black
                                    : Colors.grey.shade600,
                          ),
                        ),
                      );
                    }),
                  ),
                  //                   Consumer<WeatherProvider>(
                  //   builder: (context, provider, child) {
                  //     if (provider.isHourlyLoading) {
                  //       return CircularProgressIndicator();
                  //     }

                  //     final hourlyData = provider.hourlyList;
                  //     if (hourlyData.isEmpty) {
                  //       return Text("No hourly data available");
                  //     }

                  //     return ListView.builder(
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount: hourlyData.length,
                  //       itemBuilder: (context, index) {
                  //         final hour = hourlyData[index];
                  //         return Text("${hour.tempC}° at ${hour.time}");
                  //       },
                  //     );
                  //   },
                  // ),
                  FutureBuilder(
                    future: context.read<WeatherProvider>().getHourlyWeather(
                      "London",
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      }
                      final weatherData = snapshot.data;
                      if (weatherData == null) {
                        return Center(child: Text("no hourly weather"));
                      }
                      return SizedBox(
                        height: height * 0.14,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              weatherData.forecast.forecastday[0].hour.length,
                          itemBuilder: (context, index) {
                            HourlyCurrent hourlyCurrent =
                                weatherData.forecast.forecastday[0].hour[index];

                            final currentDateTime = DateTime.now();
                            final hourDateTime = DateTime.parse(
                              hourlyCurrent.time!,
                            );

                            final isNow =
                                hourDateTime.hour == currentDateTime.hour &&
                                hourDateTime.day == currentDateTime.day &&
                                hourDateTime.month == currentDateTime.month &&
                                hourDateTime.year == currentDateTime.year;

                            final displayTime =
                                isNow
                                    ? "now"
                                    : DateFormat(
                                      "h:mma",
                                    ).format(hourDateTime); // Example: 2:00PM

                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.015,
                              ),
                              child: GestureDetector(
                                onTap:
                                    () => setState(
                                      () => selectedInfoCloud = index,
                                    ),
                                child: Container(
                                  padding: EdgeInsets.all(width * 0.025),
                                  decoration: BoxDecoration(
                                    color:
                                        selectedInfoCloud == index
                                            ? Colors.white70
                                            : Colors.white30,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AutoSizeText(
                                        displayTime,
                                        style: TextStyle(fontSize: font),
                                      ),
                                      Image.network(
                                        "https:${hourlyCurrent.condition.icon}",
                                        height: height * 0.05,
                                      ),
                                      AutoSizeText(
                                        hourlyCurrent.tempC.toInt().toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: font * 1.1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row buildSearchWidget(double font, double width) {
    return Row(
      // spacing: width * 0.2,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ValueListenableBuilder(
          valueListenable: isCloseVisible,
          builder: (context, value, child) {
            if (value) {
              return IconButton(
                onPressed: () => isCloseVisible.value = true,
                icon: Icon(Icons.remove, size: font * 1.8),
              );
            } else {
              return IconButton(
                onPressed: () => isCloseVisible.value = true,
                icon: Icon(Icons.search, size: font * 1.8),
              );
            }
          },
        ),
        ValueListenableBuilder(
          valueListenable: isCloseVisible,
          builder: (context, value, child) {
            if (value) {
              return SizedBox(
                width: width * 0.6,
                child: TextField(
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      isCloseVisible.value = true;
                    } else {
                      isCloseVisible.value = false;
                    }
                  },

                  onSubmitted: (value) {
                    context.read<WeatherProvider>().getCurrentWeather(
                      cityNameController.text.trim(),
                    );
                    isCloseVisible.value = false;
                    cityNameController.clear();
                  },
                  controller: cityNameController,
                  decoration: InputDecoration(
                    suffixIcon: ValueListenableBuilder(
                      valueListenable: isCloseVisible,
                      builder: (context, value, child) {
                        if (value) {
                          return IconButton(
                            onPressed: () {
                              cityNameController.clear();
                              // context.read<WeatherProvider>().getCurrentWeather("London");
                            },
                            icon: Icon(Icons.cancel),
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(51, 255, 153, 0),
                    hintText: "search",
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade200),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: AutoSizeText(
                  "•  •  •  ━━  •",
                  style: TextStyle(fontSize: font * 1.2),
                ),
              );
            }
          },
        ),

        IconButton(onPressed: () {}, icon: Icon(Icons.menu, size: font * 1.8)),
      ],
    );
  }

  Consumer<WeatherProvider> buildWeatherEffect() {
    return Consumer<WeatherProvider>(
      builder: (context, value, child) {
        if (!value.isLoading) {
          return WeatherEffect(condition: value.weatherCondition);
        }
        return SizedBox.shrink();
      },
    );
  }

  Consumer<WeatherProvider> buildBackgroundWidget(double height) {
    return Consumer<WeatherProvider>(
      builder:
          (context, value, child) => AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: getGradientColors(value.weatherCondition),
              ),
            ),
          ),
    );
  }

  Consumer buildCurrentWeather(double font, double height, double width) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        if (weatherProvider.isLoading) {
          return weatherShimmer(font, height, width);
        } else if (weatherProvider.errorMessage.isNotEmpty) {
          return Center(child: Text(weatherProvider.errorMessage));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              weatherProvider.currentWeatherData?.location.name ??
                  "Joylashuv olishda muammo",
              style: TextStyle(
                fontSize: font * 1.9,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 5),
            AutoSizeText(
              DateFormat.MMMEd().format(
                DateTime.parse(
                  weatherProvider.currentWeatherData?.current.lastUpdated
                          .toString() ??
                      "",
                ),
              ),
              style: TextStyle(color: Colors.grey, fontSize: font),
            ),
            Row(
              children: [
                Image.network(
                  "https:${weatherProvider.currentWeatherData?.current.condition.icon}",
                  height: height * 0.15,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: width * 0.03),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      weatherProvider.currentWeatherData?.current.feelslikeC
                              .toString() ??
                          "",
                      style: TextStyle(
                        fontSize: font * 4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    AutoSizeText(
                      weatherProvider
                              .currentWeatherData
                              ?.current
                              .condition
                              .text ??
                          "",
                      style: TextStyle(fontSize: font * 1.2),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                infoContainer(
                  condition: weatherProvider.weatherCondition,
                  height,
                  width,
                  svgPath: "assets/svgs/barometer.svg",
                  text: "Pressure",
                  info:
                      weatherProvider.currentWeatherData?.current.pressureMb
                          .toString() ??
                      "",
                ),
                infoContainer(
                  condition: weatherProvider.weatherCondition,

                  height,
                  width,
                  svgPath: "assets/svgs/wind.svg",
                  text: "Wind",
                  info:
                      "${weatherProvider.currentWeatherData?.current.windKph.toString()} km/h",
                ),
                infoContainer(
                  condition: weatherProvider.weatherCondition,

                  height,
                  width,
                  svgPath: "assets/svgs/humidy.svg",
                  text: "Humiditiy",
                  info:
                      "${weatherProvider.currentWeatherData?.current.humidity} %",
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Container infoContainer(
    double height,
    double width, {
    required String svgPath,
    required String text,
    required String info,
    required String condition, // <-- New parameter
  }) {
    final font = width * 0.035;

    return Container(
      padding: EdgeInsets.all(width * 0.025),
      margin: EdgeInsets.only(bottom: height * 0.01),
      height: height * 0.09,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: getInfoContainerColor(condition), // Dynamic color
      ),
      child: Row(
        children: [
          Container(
            height: height * 0.05,
            width: width * 0.11,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: SvgPicture.asset(svgPath, fit: BoxFit.cover),
          ),
          SizedBox(width: width * 0.03),
          AutoSizeText(text, style: TextStyle(fontSize: font)),
          const Spacer(),
          AutoSizeText(info, style: TextStyle(fontSize: font)),
        ],
      ),
    );
  }

  Widget weatherShimmer(double font, double height, double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: width * 0.5, height: font * 2, color: Colors.white),
          SizedBox(height: 10),
          Container(
            width: width * 0.3,
            height: font * 1.2,
            color: Colors.white,
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Container(
                height: height * 0.15,
                width: height * 0.15,
                color: Colors.white,
              ),
              SizedBox(width: width * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width * 0.3,
                    height: font * 4,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: width * 0.25,
                    height: font * 1.5,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (_) {
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                height: height * 0.1,
                width: width,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
