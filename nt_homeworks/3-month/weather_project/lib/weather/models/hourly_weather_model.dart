import 'package:json_annotation/json_annotation.dart';

part 'hourly_weather_model.g.dart';

@JsonSerializable()
class HourlyWeatherModel {
  @JsonKey(name: "location")
  HourlyLocation location;
  @JsonKey(name: "current")
  HourlyCurrent current;
  @JsonKey(name: "forecast")
  HourlyForecast forecast;

  HourlyWeatherModel({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) =>
      _$HourlyWeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyWeatherModelToJson(this);
}

@JsonSerializable()
class HourlyCurrent {
  @JsonKey(name: "last_updated_epoch")
  int? lastUpdatedEpoch;
  @JsonKey(name: "last_updated")
  String? lastUpdated;
  @JsonKey(name: "temp_c")
  double tempC;
  @JsonKey(name: "temp_f")
  double tempF;
  @JsonKey(name: "is_day")
  int isDay;
  @JsonKey(name: "condition")
  HourlyCondition condition;
  @JsonKey(name: "wind_mph")
  double windMph;
  @JsonKey(name: "wind_kph")
  double windKph;
  @JsonKey(name: "wind_degree")
  int windDegree;
  @JsonKey(name: "wind_dir")
  String windDir;
  @JsonKey(name: "pressure_mb")
  int pressureMb;
  @JsonKey(name: "pressure_in")
  double pressureIn;
  @JsonKey(name: "precip_mm")
  double precipMm;
  @JsonKey(name: "precip_in")
  int precipIn;
  @JsonKey(name: "humidity")
  int humidity;
  @JsonKey(name: "cloud")
  int cloud;
  @JsonKey(name: "feelslike_c")
  double feelslikeC;
  @JsonKey(name: "feelslike_f")
  double feelslikeF;
  @JsonKey(name: "windchill_c")
  double windchillC;
  @JsonKey(name: "windchill_f")
  double windchillF;
  @JsonKey(name: "heatindex_c")
  double heatindexC;
  @JsonKey(name: "heatindex_f")
  double heatindexF;
  @JsonKey(name: "dewpoint_c")
  double dewpointC;
  @JsonKey(name: "dewpoint_f")
  double dewpointF;
  @JsonKey(name: "vis_km")
  int visKm;
  @JsonKey(name: "vis_miles")
  int visMiles;
  @JsonKey(name: "uv")
  double uv;
  @JsonKey(name: "gust_mph")
  double gustMph;
  @JsonKey(name: "gust_kph")
  double gustKph;
  @JsonKey(name: "time_epoch")
  int? timeEpoch;
  @JsonKey(name: "time")
  String? time;
  @JsonKey(name: "snow_cm")
  int? snowCm;
  @JsonKey(name: "will_it_rain")
  int? willItRain;
  @JsonKey(name: "chance_of_rain")
  int? chanceOfRain;
  @JsonKey(name: "will_it_snow")
  int? willItSnow;
  @JsonKey(name: "chance_of_snow")
  int? chanceOfSnow;

  HourlyCurrent({
    this.lastUpdatedEpoch,
    this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.windchillC,
    required this.windchillF,
    required this.heatindexC,
    required this.heatindexF,
    required this.dewpointC,
    required this.dewpointF,
    required this.visKm,
    required this.visMiles,
    required this.uv,
    required this.gustMph,
    required this.gustKph,
    this.timeEpoch,
    this.time,
    this.snowCm,
    this.willItRain,
    this.chanceOfRain,
    this.willItSnow,
    this.chanceOfSnow,
  });

  factory HourlyCurrent.fromJson(Map<String, dynamic> json) =>
      _$HourlyCurrentFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyCurrentToJson(this);
}

@JsonSerializable()
class HourlyCondition {
  @JsonKey(name: "text")
  String text;
  @JsonKey(name: "icon")
  String icon;
  @JsonKey(name: "code")
  int code;

  HourlyCondition({required this.text, required this.icon, required this.code});

  factory HourlyCondition.fromJson(Map<String, dynamic> json) =>
      _$HourlyConditionFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyConditionToJson(this);
}

@JsonSerializable()
class HourlyForecast {
  @JsonKey(name: "forecastday")
  List<HourlyForecastday> forecastday;

  HourlyForecast({required this.forecastday});

  factory HourlyForecast.fromJson(Map<String, dynamic> json) =>
      _$HourlyForecastFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyForecastToJson(this);
}

@JsonSerializable()
class HourlyForecastday {
  @JsonKey(name: "date")
  DateTime date;
  @JsonKey(name: "date_epoch")
  int dateEpoch;
  @JsonKey(name: "day")
  HourlyDay day;
  @JsonKey(name: "astro")
  Astro astro;
  @JsonKey(name: "hour")
  List<HourlyCurrent> hour;

  HourlyForecastday({
    required this.date,
    required this.dateEpoch,
    required this.day,
    required this.astro,
    required this.hour,
  });

  factory HourlyForecastday.fromJson(Map<String, dynamic> json) =>
      _$HourlyForecastdayFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyForecastdayToJson(this);
}

@JsonSerializable()
class Astro {
  @JsonKey(name: "sunrise")
  String sunrise;
  @JsonKey(name: "sunset")
  String sunset;
  @JsonKey(name: "moonrise")
  String moonrise;
  @JsonKey(name: "moonset")
  String moonset;
  @JsonKey(name: "moon_phase")
  String moonPhase;
  @JsonKey(name: "moon_illumination")
  int moonIllumination;
  @JsonKey(name: "is_moon_up")
  int isMoonUp;
  @JsonKey(name: "is_sun_up")
  int isSunUp;

  Astro({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.moonIllumination,
    required this.isMoonUp,
    required this.isSunUp,
  });

  factory Astro.fromJson(Map<String, dynamic> json) => _$AstroFromJson(json);

  Map<String, dynamic> toJson() => _$AstroToJson(this);
}

@JsonSerializable()
class HourlyDay {
  @JsonKey(name: "maxtemp_c")
  int maxtempC;
  @JsonKey(name: "maxtemp_f")
  double maxtempF;
  @JsonKey(name: "mintemp_c")
  double mintempC;
  @JsonKey(name: "mintemp_f")
  double mintempF;
  @JsonKey(name: "avgtemp_c")
  double avgtempC;
  @JsonKey(name: "avgtemp_f")
  double avgtempF;
  @JsonKey(name: "maxwind_mph")
  double maxwindMph;
  @JsonKey(name: "maxwind_kph")
  double maxwindKph;
  @JsonKey(name: "totalprecip_mm")
  double totalprecipMm;
  @JsonKey(name: "totalprecip_in")
  int totalprecipIn;
  @JsonKey(name: "totalsnow_cm")
  int totalsnowCm;
  @JsonKey(name: "avgvis_km")
  int avgvisKm;
  @JsonKey(name: "avgvis_miles")
  int avgvisMiles;
  @JsonKey(name: "avghumidity")
  int avghumidity;
  @JsonKey(name: "daily_will_it_rain")
  int dailyWillItRain;
  @JsonKey(name: "daily_chance_of_rain")
  int dailyChanceOfRain;
  @JsonKey(name: "daily_will_it_snow")
  int dailyWillItSnow;
  @JsonKey(name: "daily_chance_of_snow")
  int dailyChanceOfSnow;
  @JsonKey(name: "condition")
  HourlyCondition condition;
  @JsonKey(name: "uv")
  double uv;

  HourlyDay({
    required this.maxtempC,
    required this.maxtempF,
    required this.mintempC,
    required this.mintempF,
    required this.avgtempC,
    required this.avgtempF,
    required this.maxwindMph,
    required this.maxwindKph,
    required this.totalprecipMm,
    required this.totalprecipIn,
    required this.totalsnowCm,
    required this.avgvisKm,
    required this.avgvisMiles,
    required this.avghumidity,
    required this.dailyWillItRain,
    required this.dailyChanceOfRain,
    required this.dailyWillItSnow,
    required this.dailyChanceOfSnow,
    required this.condition,
    required this.uv,
  });

  factory HourlyDay.fromJson(Map<String, dynamic> json) => _$HourlyDayFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyDayToJson(this);
}

@JsonSerializable()
class HourlyLocation {
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "region")
  String region;
  @JsonKey(name: "country")
  String country;
  @JsonKey(name: "lat")
  double lat;
  @JsonKey(name: "lon")
  double lon;
  @JsonKey(name: "tz_id")
  String tzId;
  @JsonKey(name: "localtime_epoch")
  int localtimeEpoch;
  @JsonKey(name: "localtime")
  String localtime;

  HourlyLocation({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtimeEpoch,
    required this.localtime,
  });

  factory HourlyLocation.fromJson(Map<String, dynamic> json) =>
      _$HourlyLocationFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyLocationToJson(this);
}
