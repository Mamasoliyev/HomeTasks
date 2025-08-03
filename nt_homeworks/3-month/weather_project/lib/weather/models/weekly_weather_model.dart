import 'package:json_annotation/json_annotation.dart';

part 'weekly_weather_model.g.dart';

@JsonSerializable()
class WeeklyWeatherModel {
  @JsonKey(name: "location")
  final WeeklyLocation? location;
  @JsonKey(name: "current")
  final WeeklyCurrent? current;
  @JsonKey(name: "forecast")
  final WeeklyForecast? forecast;

  WeeklyWeatherModel({this.location, this.current, this.forecast});

  factory WeeklyWeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeeklyWeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeeklyWeatherModelToJson(this);
}

@JsonSerializable()
class WeeklyCurrent {
  @JsonKey(name: "last_updated_epoch")
  final int? lastUpdatedEpoch;
  @JsonKey(name: "last_updated")
  final String? lastUpdated;
  @JsonKey(name: "temp_c")
  final double? tempC;
  @JsonKey(name: "temp_f")
  final double? tempF;
  @JsonKey(name: "is_day")
  final int? isDay;
  @JsonKey(name: "condition")
  final WeeklyCondition? condition;
  @JsonKey(name: "wind_mph")
  final double? windMph;
  @JsonKey(name: "wind_kph")
  final double? windKph;
  @JsonKey(name: "wind_degree")
  final int? windDegree;
  @JsonKey(name: "wind_dir")
  final String? windDir;
  @JsonKey(name: "pressure_mb")
  final int? pressureMb;
  @JsonKey(name: "pressure_in")
  final double? pressureIn;
  @JsonKey(name: "precip_mm")
  final double? precipMm;
  @JsonKey(name: "precip_in")
  final double? precipIn;
  @JsonKey(name: "humidity")
  final int? humidity;
  @JsonKey(name: "cloud")
  final int? cloud;
  @JsonKey(name: "feelslike_c")
  final double? feelslikeC;
  @JsonKey(name: "feelslike_f")
  final double? feelslikeF;
  @JsonKey(name: "windchill_c")
  final double? windchillC;
  @JsonKey(name: "windchill_f")
  final double? windchillF;
  @JsonKey(name: "heatindex_c")
  final double? heatindexC;
  @JsonKey(name: "heatindex_f")
  final double? heatindexF;
  @JsonKey(name: "dewpoint_c")
  final double? dewpointC;
  @JsonKey(name: "dewpoint_f")
  final double? dewpointF;
  @JsonKey(name: "vis_km")
  final int? visKm;
  @JsonKey(name: "vis_miles")
  final int? visMiles;
  @JsonKey(name: "uv")
  final double? uv;
  @JsonKey(name: "gust_mph")
  final double? gustMph;
  @JsonKey(name: "gust_kph")
  final double? gustKph;
  @JsonKey(name: "time_epoch")
  final int? timeEpoch;
  @JsonKey(name: "time")
  final String? time;
  @JsonKey(name: "snow_cm")
  final int? snowCm;
  @JsonKey(name: "will_it_rain")
  final int? willItRain;
  @JsonKey(name: "chance_of_rain")
  final int? chanceOfRain;
  @JsonKey(name: "will_it_snow")
  final int? willItSnow;
  @JsonKey(name: "chance_of_snow")
  final int? chanceOfSnow;

  WeeklyCurrent({
    this.lastUpdatedEpoch,
    this.lastUpdated,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.windchillC,
    this.windchillF,
    this.heatindexC,
    this.heatindexF,
    this.dewpointC,
    this.dewpointF,
    this.visKm,
    this.visMiles,
    this.uv,
    this.gustMph,
    this.gustKph,
    this.timeEpoch,
    this.time,
    this.snowCm,
    this.willItRain,
    this.chanceOfRain,
    this.willItSnow,
    this.chanceOfSnow,
  });

  factory WeeklyCurrent.fromJson(Map<String, dynamic> json) =>
      _$WeeklyCurrentFromJson(json);

  Map<String, dynamic> toJson() => _$WeeklyCurrentToJson(this);
}

@JsonSerializable()
class WeeklyCondition {
  @JsonKey(name: "text")
  final String? text;
  @JsonKey(name: "icon")
  final String? icon;
  @JsonKey(name: "code")
  final int? code;

  WeeklyCondition({this.text, this.icon, this.code});

  factory WeeklyCondition.fromJson(Map<String, dynamic> json) =>
      _$WeeklyConditionFromJson(json);

  Map<String, dynamic> toJson() => _$WeeklyConditionToJson(this);
}

@JsonSerializable()
class WeeklyForecast {
  @JsonKey(name: "forecastday")
  final List<WeeklyForecastday>? forecastday;

  WeeklyForecast({this.forecastday});

  factory WeeklyForecast.fromJson(Map<String, dynamic> json) =>
      _$WeeklyForecastFromJson(json);

  Map<String, dynamic> toJson() => _$WeeklyForecastToJson(this);
}

@JsonSerializable()
class WeeklyForecastday {
  @JsonKey(name: "date")
  final DateTime? date;
  @JsonKey(name: "date_epoch")
  final int? dateEpoch;
  @JsonKey(name: "day")
  final WeeklyDay? day;
  @JsonKey(name: "astro")
  final WeeklyAstro? astro;
  @JsonKey(name: "hour")
  final List<WeeklyCurrent>? hour;

  WeeklyForecastday({
    this.date,
    this.dateEpoch,
    this.day,
    this.astro,
    this.hour,
  });

  factory WeeklyForecastday.fromJson(Map<String, dynamic> json) =>
      _$WeeklyForecastdayFromJson(json);

  Map<String, dynamic> toJson() => _$WeeklyForecastdayToJson(this);
}

@JsonSerializable()
class WeeklyAstro {
  @JsonKey(name: "sunrise")
  final String? sunrise;
  @JsonKey(name: "sunset")
  final String? sunset;
  @JsonKey(name: "moonrise")
  final String? moonrise;
  @JsonKey(name: "moonset")
  final String? moonset;
  @JsonKey(name: "moon_phase")
  final String? moonPhase;
  @JsonKey(name: "moon_illumination")
  final int? moonIllumination;
  @JsonKey(name: "is_moon_up")
  final int? isMoonUp;
  @JsonKey(name: "is_sun_up")
  final int? isSunUp;

  WeeklyAstro({
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.moonIllumination,
    this.isMoonUp,
    this.isSunUp,
  });

  factory WeeklyAstro.fromJson(Map<String, dynamic> json) =>
      _$WeeklyAstroFromJson(json);

  Map<String, dynamic> toJson() => _$WeeklyAstroToJson(this);
}

@JsonSerializable()
class WeeklyDay {
  @JsonKey(name: "maxtemp_c")
  final double? maxtempC;
  @JsonKey(name: "maxtemp_f")
  final double? maxtempF;
  @JsonKey(name: "mintemp_c")
  final double? mintempC;
  @JsonKey(name: "mintemp_f")
  final double? mintempF;
  @JsonKey(name: "avgtemp_c")
  final double? avgtempC;
  @JsonKey(name: "avgtemp_f")
  final double? avgtempF;
  @JsonKey(name: "maxwind_mph")
  final double? maxwindMph;
  @JsonKey(name: "maxwind_kph")
  final double? maxwindKph;
  @JsonKey(name: "totalprecip_mm")
  final double? totalprecipMm;
  @JsonKey(name: "totalprecip_in")
  final double? totalprecipIn;
  @JsonKey(name: "totalsnow_cm")
  final int? totalsnowCm;
  @JsonKey(name: "avgvis_km")
  final double? avgvisKm;
  @JsonKey(name: "avgvis_miles")
  final int? avgvisMiles;
  @JsonKey(name: "avghumidity")
  final int? avghumidity;
  @JsonKey(name: "daily_will_it_rain")
  final int? dailyWillItRain;
  @JsonKey(name: "daily_chance_of_rain")
  final int? dailyChanceOfRain;
  @JsonKey(name: "daily_will_it_snow")
  final int? dailyWillItSnow;
  @JsonKey(name: "daily_chance_of_snow")
  final int? dailyChanceOfSnow;
  @JsonKey(name: "condition")
  final WeeklyCondition? condition;
  @JsonKey(name: "uv")
  final double? uv;

  WeeklyDay({
    this.maxtempC,
    this.maxtempF,
    this.mintempC,
    this.mintempF,
    this.avgtempC,
    this.avgtempF,
    this.maxwindMph,
    this.maxwindKph,
    this.totalprecipMm,
    this.totalprecipIn,
    this.totalsnowCm,
    this.avgvisKm,
    this.avgvisMiles,
    this.avghumidity,
    this.dailyWillItRain,
    this.dailyChanceOfRain,
    this.dailyWillItSnow,
    this.dailyChanceOfSnow,
    this.condition,
    this.uv,
  });

  factory WeeklyDay.fromJson(Map<String, dynamic> json) =>
      _$WeeklyDayFromJson(json);

  Map<String, dynamic> toJson() => _$WeeklyDayToJson(this);
}

@JsonSerializable()
class WeeklyLocation {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "region")
  final String? region;
  @JsonKey(name: "country")
  final String? country;
  @JsonKey(name: "lat")
  final double? lat;
  @JsonKey(name: "lon")
  final double? lon;
  @JsonKey(name: "tz_id")
  final String? tzId;
  @JsonKey(name: "localtime_epoch")
  final int? localtimeEpoch;
  @JsonKey(name: "localtime")
  final String? localtime;

  WeeklyLocation({
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.tzId,
    this.localtimeEpoch,
    this.localtime,
  });

  factory WeeklyLocation.fromJson(Map<String, dynamic> json) =>
      _$WeeklyLocationFromJson(json);

  Map<String, dynamic> toJson() => _$WeeklyLocationToJson(this);
}
