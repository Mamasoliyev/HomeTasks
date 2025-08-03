import "package:flutter/material.dart";

Container buildTodayWeatherInfo() {
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            gradient: LinearGradient(
              colors: [Color(0xFF1E4DC5), Color(0xFF61A4E6), Color(0xFFFFDDB5)],

              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hari ini",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Figtree",
                  color: Colors.white,
                ),
              ),
              Text(
                "Minggu, 13 Des | 15:00",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Figtree",
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Text(
                    "23°C",
                    style: TextStyle(
                      fontSize: 72,
                      fontFamily: "Figtree",
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 80),
                  Icon(Icons.wb_cloudy, color: Colors.white, size: 80),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Siang 25°c, Malam 18°c",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Figtree",
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 80),
                  Text(
                    "Hujan Lebat",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Figtree",
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 25,
                  children: [
                    buildHourlyWeatherInfo(
                      isToday: true,
                      celcius: 23,
                      hour: "15:00",
                      percentage: "95",
                    ),
                    buildHourlyWeatherInfo(
                      celcius: 23,
                      hour: "16:00",
                      percentage: "85",
                    ),
                    buildHourlyWeatherInfo(
                      celcius: 23,
                      hour: "17:00",
                      percentage: "75",
                    ),
                    buildHourlyWeatherInfo(
                      celcius: 23,
                      hour: "18:00",
                      percentage: "70",
                    ),
                    buildHourlyWeatherInfo(
                      celcius: 23,
                      hour: "19:00",
                      percentage: "55",
                    ),
                    buildHourlyWeatherInfo(
                      celcius: 23,
                      hour: "20:00",
                      percentage: "50",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.blue),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Lihat selengkapnya"),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_right_alt_outlined),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Column buildHourlyWeatherInfo({
  required String hour,
  required String percentage,
  required double celcius,
  bool isToday = false,
}) {
  return Column(
    spacing: 5,
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: isToday ? Colors.red : Colors.white,
          shape: BoxShape.circle,
        ),
      ),
      Text(hour, style: TextStyle(fontFamily: "Figtree", fontSize: 12)),
      Text(
        "$percentage%",
        style: TextStyle(
          fontFamily: "Figtree",
          fontSize: 10,
          color: Colors.blue,
        ),
      ),
      Icon(Icons.cloudy_snowing, color: Colors.grey),

      Text("$celcius°C", style: TextStyle(fontFamily: "Figtree", fontSize: 12)),
    ],
  );
}

Container buildLocationWidget() {
  return Container(
    width: 300,
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.location_on, color: Colors.red, size: 30),
        Text(
          "Tashkent, Uzbekitan",
          style: TextStyle(
            fontFamily: "Figtree",
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}

Widget buildForecastList() {
  final List<Map<String, String>> forecast = [
    {
      "day": "Senin, 14 Des",
      "dayTemp": "26°C",
      "nightTemp": "18°C",
      "icon": "🌩️",
    },
    {
      "day": "Selasa, 15 Des",
      "dayTemp": "26°C",
      "nightTemp": "18°C",
      "icon": "🌧️",
    },
    {
      "day": "Rabu, 16 Des",
      "dayTemp": "25°C",
      "nightTemp": "19°C",
      "icon": "🌧️",
    },
    {
      "day": "Kamis, 17 Des",
      "dayTemp": "27°C",
      "nightTemp": "18°C",
      "icon": "🌤️",
    },
    {
      "day": "Jumat, 18 Des",
      "dayTemp": "26°C",
      "nightTemp": "18°C",
      "icon": "🌩️",
    },
    {
      "day": "Sabtu, 19 Des",
      "dayTemp": "26°C",
      "nightTemp": "17°C",
      "icon": "🌧️",
    },
    {
      "day": "Minggu, 20 Des",
      "dayTemp": "25°C",
      "nightTemp": "18°C",
      "icon": "🌧️",
    },
  ];

  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.grey.shade200),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
      ],
    ),
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '7 Hari Kedepan',
          style: TextStyle(
            fontFamily: "Figtree",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            for (int i = 0; i < forecast.length; i++) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            forecast[i]["day"]!,
                            style: const TextStyle(
                              fontFamily: "Figtree",
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Siang ${forecast[i]["dayTemp"]}, Malam ${forecast[i]["nightTemp"]}",
                            style: TextStyle(
                              fontFamily: "Figtree",
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      forecast[i]["icon"]!,
                      style: const TextStyle(
                        fontFamily: "Figtree",
                        fontSize: 28,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  ],
                ),
              ),
              if (i != forecast.length - 1)
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFF0F0F0),
                ),
            ],
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          "Sumber: bmkg.go.id",
          style: TextStyle(
            fontFamily: "Figtree",
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}
