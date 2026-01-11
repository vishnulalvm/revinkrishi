import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/weather_entity.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  final double lat;
  final double lon;
  final String timezone;
  @JsonKey(name: 'timezone_offset')
  final int timezoneOffset;
  final CurrentWeatherModel current;
  final List<DailyWeatherModel> daily;

  WeatherModel({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.daily,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  WeatherEntity toEntity() {
    return WeatherEntity(
      current: current.toEntity(),
      daily: daily.map((d) => d.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class CurrentWeatherModel {
  final int dt;
  final double temp;
  @JsonKey(name: 'feels_like')
  final double feelsLike;
  final int pressure;
  final int humidity;
  @JsonKey(name: 'dew_point')
  final double dewPoint;
  final int clouds;
  final double uvi;
  final int visibility;
  @JsonKey(name: 'wind_speed')
  final double windSpeed;
  @JsonKey(name: 'wind_deg')
  final int windDeg;
  final List<WeatherConditionModel> weather;

  CurrentWeatherModel({
    required this.dt,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.clouds,
    required this.uvi,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.weather,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWeatherModelToJson(this);

  CurrentWeather toEntity() {
    final weatherCondition = weather.isNotEmpty
        ? weather.first
        : WeatherConditionModel(
            id: 0,
            main: 'Unknown',
            description: 'Unknown',
            icon: '01d',
          );

    return CurrentWeather(
      temp: temp,
      feelsLike: feelsLike,
      humidity: humidity,
      windSpeed: windSpeed,
      pressure: pressure,
      clouds: clouds,
      uvi: uvi.toInt(),
      weatherMain: weatherCondition.main,
      weatherDescription: weatherCondition.description,
      weatherIcon: weatherCondition.icon,
    );
  }
}

@JsonSerializable()
class DailyWeatherModel {
  final int dt;
  final TempModel temp;
  @JsonKey(name: 'feels_like')
  final FeelsLikeModel feelsLike;
  final int pressure;
  final int humidity;
  @JsonKey(name: 'dew_point')
  final double dewPoint;
  @JsonKey(name: 'wind_speed')
  final double windSpeed;
  @JsonKey(name: 'wind_deg')
  final int windDeg;
  final int clouds;
  final double pop;
  final double? rain;
  final double uvi;
  final List<WeatherConditionModel> weather;

  DailyWeatherModel({
    required this.dt,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.windDeg,
    required this.clouds,
    required this.pop,
    this.rain,
    required this.uvi,
    required this.weather,
  });

  factory DailyWeatherModel.fromJson(Map<String, dynamic> json) =>
      _$DailyWeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$DailyWeatherModelToJson(this);

  DailyWeather toEntity() {
    final weatherCondition = weather.isNotEmpty
        ? weather.first
        : WeatherConditionModel(
            id: 0,
            main: 'Unknown',
            description: 'Unknown',
            icon: '01d',
          );

    return DailyWeather(
      date: DateTime.fromMillisecondsSinceEpoch(dt * 1000),
      tempMax: temp.max,
      tempMin: temp.min,
      pop: (pop * 100).toInt(),
      weatherMain: weatherCondition.main,
      weatherDescription: weatherCondition.description,
      weatherIcon: weatherCondition.icon,
      humidity: humidity,
      windSpeed: windSpeed,
    );
  }
}

@JsonSerializable()
class TempModel {
  final double day;
  final double min;
  final double max;
  final double night;
  final double eve;
  final double morn;

  TempModel({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  factory TempModel.fromJson(Map<String, dynamic> json) =>
      _$TempModelFromJson(json);

  Map<String, dynamic> toJson() => _$TempModelToJson(this);
}

@JsonSerializable()
class FeelsLikeModel {
  final double day;
  final double night;
  final double eve;
  final double morn;

  FeelsLikeModel({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  factory FeelsLikeModel.fromJson(Map<String, dynamic> json) =>
      _$FeelsLikeModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeelsLikeModelToJson(this);
}

@JsonSerializable()
class WeatherConditionModel {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherConditionModel({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherConditionModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherConditionModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherConditionModelToJson(this);
}
