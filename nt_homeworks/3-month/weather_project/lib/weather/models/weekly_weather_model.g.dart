// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeeklyWeatherModel _$WeeklyWeatherModelFromJson(
  Map<String, dynamic> json,
) => WeeklyWeatherModel(
  location:
      json['location'] == null
          ? null
          : WeeklyLocation.fromJson(json['location'] as Map<String, dynamic>),
  current:
      json['current'] == null
          ? null
          : WeeklyCurrent.fromJson(json['current'] as Map<String, dynamic>),
  forecast:
      json['forecast'] == null
          ? null
          : WeeklyForecast.fromJson(json['forecast'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WeeklyWeatherModelToJson(WeeklyWeatherModel instance) =>
    <String, dynamic>{
      'location': instance.location,
      'current': instance.current,
      'forecast': instance.forecast,
    };

WeeklyCurrent _$WeeklyCurrentFromJson(Map<String, dynamic> json) =>
    WeeklyCurrent(
      lastUpdatedEpoch: (json['last_updated_epoch'] as num?)?.toInt(),
      lastUpdated: json['last_updated'] as String?,
      tempC: (json['temp_c'] as num?)?.toDouble(),
      tempF: (json['temp_f'] as num?)?.toDouble(),
      isDay: (json['is_day'] as num?)?.toInt(),
      condition:
          json['condition'] == null
              ? null
              : WeeklyCondition.fromJson(
                json['condition'] as Map<String, dynamic>,
              ),
      windMph: (json['wind_mph'] as num?)?.toDouble(),
      windKph: (json['wind_kph'] as num?)?.toDouble(),
      windDegree: (json['wind_degree'] as num?)?.toInt(),
      windDir: json['wind_dir'] as String?,
      pressureMb: (json['pressure_mb'] as num?)?.toInt(),
      pressureIn: (json['pressure_in'] as num?)?.toDouble(),
      precipMm: (json['precip_mm'] as num?)?.toDouble(),
      precipIn: (json['precip_in'] as num?)?.toDouble(),
      humidity: (json['humidity'] as num?)?.toInt(),
      cloud: (json['cloud'] as num?)?.toInt(),
      feelslikeC: (json['feelslike_c'] as num?)?.toDouble(),
      feelslikeF: (json['feelslike_f'] as num?)?.toDouble(),
      windchillC: (json['windchill_c'] as num?)?.toDouble(),
      windchillF: (json['windchill_f'] as num?)?.toDouble(),
      heatindexC: (json['heatindex_c'] as num?)?.toDouble(),
      heatindexF: (json['heatindex_f'] as num?)?.toDouble(),
      dewpointC: (json['dewpoint_c'] as num?)?.toDouble(),
      dewpointF: (json['dewpoint_f'] as num?)?.toDouble(),
      visKm: (json['vis_km'] as num?)?.toInt(),
      visMiles: (json['vis_miles'] as num?)?.toInt(),
      uv: (json['uv'] as num?)?.toDouble(),
      gustMph: (json['gust_mph'] as num?)?.toDouble(),
      gustKph: (json['gust_kph'] as num?)?.toDouble(),
      timeEpoch: (json['time_epoch'] as num?)?.toInt(),
      time: json['time'] as String?,
      snowCm: (json['snow_cm'] as num?)?.toInt(),
      willItRain: (json['will_it_rain'] as num?)?.toInt(),
      chanceOfRain: (json['chance_of_rain'] as num?)?.toInt(),
      willItSnow: (json['will_it_snow'] as num?)?.toInt(),
      chanceOfSnow: (json['chance_of_snow'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WeeklyCurrentToJson(WeeklyCurrent instance) =>
    <String, dynamic>{
      'last_updated_epoch': instance.lastUpdatedEpoch,
      'last_updated': instance.lastUpdated,
      'temp_c': instance.tempC,
      'temp_f': instance.tempF,
      'is_day': instance.isDay,
      'condition': instance.condition,
      'wind_mph': instance.windMph,
      'wind_kph': instance.windKph,
      'wind_degree': instance.windDegree,
      'wind_dir': instance.windDir,
      'pressure_mb': instance.pressureMb,
      'pressure_in': instance.pressureIn,
      'precip_mm': instance.precipMm,
      'precip_in': instance.precipIn,
      'humidity': instance.humidity,
      'cloud': instance.cloud,
      'feelslike_c': instance.feelslikeC,
      'feelslike_f': instance.feelslikeF,
      'windchill_c': instance.windchillC,
      'windchill_f': instance.windchillF,
      'heatindex_c': instance.heatindexC,
      'heatindex_f': instance.heatindexF,
      'dewpoint_c': instance.dewpointC,
      'dewpoint_f': instance.dewpointF,
      'vis_km': instance.visKm,
      'vis_miles': instance.visMiles,
      'uv': instance.uv,
      'gust_mph': instance.gustMph,
      'gust_kph': instance.gustKph,
      'time_epoch': instance.timeEpoch,
      'time': instance.time,
      'snow_cm': instance.snowCm,
      'will_it_rain': instance.willItRain,
      'chance_of_rain': instance.chanceOfRain,
      'will_it_snow': instance.willItSnow,
      'chance_of_snow': instance.chanceOfSnow,
    };

WeeklyCondition _$WeeklyConditionFromJson(Map<String, dynamic> json) =>
    WeeklyCondition(
      text: json['text'] as String?,
      icon: json['icon'] as String?,
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WeeklyConditionToJson(WeeklyCondition instance) =>
    <String, dynamic>{
      'text': instance.text,
      'icon': instance.icon,
      'code': instance.code,
    };

WeeklyForecast _$WeeklyForecastFromJson(Map<String, dynamic> json) =>
    WeeklyForecast(
      forecastday:
          (json['forecastday'] as List<dynamic>?)
              ?.map(
                (e) => WeeklyForecastday.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
    );

Map<String, dynamic> _$WeeklyForecastToJson(WeeklyForecast instance) =>
    <String, dynamic>{'forecastday': instance.forecastday};

WeeklyForecastday _$WeeklyForecastdayFromJson(Map<String, dynamic> json) =>
    WeeklyForecastday(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      dateEpoch: (json['date_epoch'] as num?)?.toInt(),
      day:
          json['day'] == null
              ? null
              : WeeklyDay.fromJson(json['day'] as Map<String, dynamic>),
      astro:
          json['astro'] == null
              ? null
              : WeeklyAstro.fromJson(json['astro'] as Map<String, dynamic>),
      hour:
          (json['hour'] as List<dynamic>?)
              ?.map((e) => WeeklyCurrent.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$WeeklyForecastdayToJson(WeeklyForecastday instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'date_epoch': instance.dateEpoch,
      'day': instance.day,
      'astro': instance.astro,
      'hour': instance.hour,
    };

WeeklyAstro _$WeeklyAstroFromJson(Map<String, dynamic> json) => WeeklyAstro(
  sunrise: json['sunrise'] as String?,
  sunset: json['sunset'] as String?,
  moonrise: json['moonrise'] as String?,
  moonset: json['moonset'] as String?,
  moonPhase: json['moon_phase'] as String?,
  moonIllumination: (json['moon_illumination'] as num?)?.toInt(),
  isMoonUp: (json['is_moon_up'] as num?)?.toInt(),
  isSunUp: (json['is_sun_up'] as num?)?.toInt(),
);

Map<String, dynamic> _$WeeklyAstroToJson(WeeklyAstro instance) =>
    <String, dynamic>{
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
      'moonrise': instance.moonrise,
      'moonset': instance.moonset,
      'moon_phase': instance.moonPhase,
      'moon_illumination': instance.moonIllumination,
      'is_moon_up': instance.isMoonUp,
      'is_sun_up': instance.isSunUp,
    };

WeeklyDay _$WeeklyDayFromJson(Map<String, dynamic> json) => WeeklyDay(
  maxtempC: (json['maxtemp_c'] as num?)?.toDouble(),
  maxtempF: (json['maxtemp_f'] as num?)?.toDouble(),
  mintempC: (json['mintemp_c'] as num?)?.toDouble(),
  mintempF: (json['mintemp_f'] as num?)?.toDouble(),
  avgtempC: (json['avgtemp_c'] as num?)?.toDouble(),
  avgtempF: (json['avgtemp_f'] as num?)?.toDouble(),
  maxwindMph: (json['maxwind_mph'] as num?)?.toDouble(),
  maxwindKph: (json['maxwind_kph'] as num?)?.toDouble(),
  totalprecipMm: (json['totalprecip_mm'] as num?)?.toDouble(),
  totalprecipIn: (json['totalprecip_in'] as num?)?.toDouble(),
  totalsnowCm: (json['totalsnow_cm'] as num?)?.toInt(),
  avgvisKm: (json['avgvis_km'] as num?)?.toDouble(),
  avgvisMiles: (json['avgvis_miles'] as num?)?.toInt(),
  avghumidity: (json['avghumidity'] as num?)?.toInt(),
  dailyWillItRain: (json['daily_will_it_rain'] as num?)?.toInt(),
  dailyChanceOfRain: (json['daily_chance_of_rain'] as num?)?.toInt(),
  dailyWillItSnow: (json['daily_will_it_snow'] as num?)?.toInt(),
  dailyChanceOfSnow: (json['daily_chance_of_snow'] as num?)?.toInt(),
  condition:
      json['condition'] == null
          ? null
          : WeeklyCondition.fromJson(json['condition'] as Map<String, dynamic>),
  uv: (json['uv'] as num?)?.toDouble(),
);

Map<String, dynamic> _$WeeklyDayToJson(WeeklyDay instance) => <String, dynamic>{
  'maxtemp_c': instance.maxtempC,
  'maxtemp_f': instance.maxtempF,
  'mintemp_c': instance.mintempC,
  'mintemp_f': instance.mintempF,
  'avgtemp_c': instance.avgtempC,
  'avgtemp_f': instance.avgtempF,
  'maxwind_mph': instance.maxwindMph,
  'maxwind_kph': instance.maxwindKph,
  'totalprecip_mm': instance.totalprecipMm,
  'totalprecip_in': instance.totalprecipIn,
  'totalsnow_cm': instance.totalsnowCm,
  'avgvis_km': instance.avgvisKm,
  'avgvis_miles': instance.avgvisMiles,
  'avghumidity': instance.avghumidity,
  'daily_will_it_rain': instance.dailyWillItRain,
  'daily_chance_of_rain': instance.dailyChanceOfRain,
  'daily_will_it_snow': instance.dailyWillItSnow,
  'daily_chance_of_snow': instance.dailyChanceOfSnow,
  'condition': instance.condition,
  'uv': instance.uv,
};

WeeklyLocation _$WeeklyLocationFromJson(Map<String, dynamic> json) =>
    WeeklyLocation(
      name: json['name'] as String?,
      region: json['region'] as String?,
      country: json['country'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      tzId: json['tz_id'] as String?,
      localtimeEpoch: (json['localtime_epoch'] as num?)?.toInt(),
      localtime: json['localtime'] as String?,
    );

Map<String, dynamic> _$WeeklyLocationToJson(WeeklyLocation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'region': instance.region,
      'country': instance.country,
      'lat': instance.lat,
      'lon': instance.lon,
      'tz_id': instance.tzId,
      'localtime_epoch': instance.localtimeEpoch,
      'localtime': instance.localtime,
    };
