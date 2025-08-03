import 'package:json_annotation/json_annotation.dart';

part 'current_weather_model.g.dart';

@JsonSerializable()
class CurrentWeatherModel {
  @JsonKey(name: "location")
  Location location;
  @JsonKey(name: "current")
  Current current;

  CurrentWeatherModel({required this.location, required this.current});

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWeatherModelToJson(this);
}

@JsonSerializable()
class Current {
  @JsonKey(name: "last_updated_epoch")
  int lastUpdatedEpoch;
  @JsonKey(name: "last_updated")
  String lastUpdated;
  @JsonKey(name: "temp_c")
  double tempC;
  @JsonKey(name: "temp_f")
  double tempF;
  @JsonKey(name: "is_day")
  int isDay;
  @JsonKey(name: "condition")
  Condition condition;
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
  int precipMm;
  @JsonKey(name: "precip_in")
  int precipIn;
  @JsonKey(name: "humidity")
  int humidity;
  @JsonKey(name: "cloud")
  int cloud;
  @JsonKey(name: "feelslike_c")
  int feelslikeC;
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

  Current({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
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
  });

  factory Current.fromJson(Map<String, dynamic> json) =>
      _$CurrentFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentToJson(this);
}

@JsonSerializable()
class Condition {
  @JsonKey(name: "text")
  String text;
  @JsonKey(name: "icon")
  String icon;
  @JsonKey(name: "code")
  int code;

  Condition({required this.text, required this.icon, required this.code});

  factory Condition.fromJson(Map<String, dynamic> json) =>
      _$ConditionFromJson(json);

  Map<String, dynamic> toJson() => _$ConditionToJson(this);
}

@JsonSerializable()
class Location {
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

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtimeEpoch,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
