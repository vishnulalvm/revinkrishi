// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) =>
    WeatherModel(
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      timezone: json['timezone'] as String,
      timezoneOffset: (json['timezone_offset'] as num).toInt(),
      current: CurrentWeatherModel.fromJson(
          json['current'] as Map<String, dynamic>),
      daily: (json['daily'] as List<dynamic>)
          .map((e) => DailyWeatherModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
      'timezone': instance.timezone,
      'timezone_offset': instance.timezoneOffset,
      'current': instance.current,
      'daily': instance.daily,
    };

CurrentWeatherModel _$CurrentWeatherModelFromJson(Map<String, dynamic> json) =>
    CurrentWeatherModel(
      dt: (json['dt'] as num).toInt(),
      temp: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
      pressure: (json['pressure'] as num).toInt(),
      humidity: (json['humidity'] as num).toInt(),
      dewPoint: (json['dew_point'] as num).toDouble(),
      clouds: (json['clouds'] as num).toInt(),
      uvi: (json['uvi'] as num).toDouble(),
      visibility: (json['visibility'] as num).toInt(),
      windSpeed: (json['wind_speed'] as num).toDouble(),
      windDeg: (json['wind_deg'] as num).toInt(),
      weather: (json['weather'] as List<dynamic>)
          .map((e) => WeatherConditionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CurrentWeatherModelToJson(
        CurrentWeatherModel instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'dew_point': instance.dewPoint,
      'clouds': instance.clouds,
      'uvi': instance.uvi,
      'visibility': instance.visibility,
      'wind_speed': instance.windSpeed,
      'wind_deg': instance.windDeg,
      'weather': instance.weather,
    };

DailyWeatherModel _$DailyWeatherModelFromJson(Map<String, dynamic> json) =>
    DailyWeatherModel(
      dt: (json['dt'] as num).toInt(),
      temp: TempModel.fromJson(json['temp'] as Map<String, dynamic>),
      feelsLike:
          FeelsLikeModel.fromJson(json['feels_like'] as Map<String, dynamic>),
      pressure: (json['pressure'] as num).toInt(),
      humidity: (json['humidity'] as num).toInt(),
      dewPoint: (json['dew_point'] as num).toDouble(),
      windSpeed: (json['wind_speed'] as num).toDouble(),
      windDeg: (json['wind_deg'] as num).toInt(),
      clouds: (json['clouds'] as num).toInt(),
      pop: (json['pop'] as num).toDouble(),
      rain: (json['rain'] as num?)?.toDouble(),
      uvi: (json['uvi'] as num).toDouble(),
      weather: (json['weather'] as List<dynamic>)
          .map((e) => WeatherConditionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DailyWeatherModelToJson(DailyWeatherModel instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'dew_point': instance.dewPoint,
      'wind_speed': instance.windSpeed,
      'wind_deg': instance.windDeg,
      'clouds': instance.clouds,
      'pop': instance.pop,
      'rain': instance.rain,
      'uvi': instance.uvi,
      'weather': instance.weather,
    };

TempModel _$TempModelFromJson(Map<String, dynamic> json) => TempModel(
      day: (json['day'] as num).toDouble(),
      min: (json['min'] as num).toDouble(),
      max: (json['max'] as num).toDouble(),
      night: (json['night'] as num).toDouble(),
      eve: (json['eve'] as num).toDouble(),
      morn: (json['morn'] as num).toDouble(),
    );

Map<String, dynamic> _$TempModelToJson(TempModel instance) => <String, dynamic>{
      'day': instance.day,
      'min': instance.min,
      'max': instance.max,
      'night': instance.night,
      'eve': instance.eve,
      'morn': instance.morn,
    };

FeelsLikeModel _$FeelsLikeModelFromJson(Map<String, dynamic> json) =>
    FeelsLikeModel(
      day: (json['day'] as num).toDouble(),
      night: (json['night'] as num).toDouble(),
      eve: (json['eve'] as num).toDouble(),
      morn: (json['morn'] as num).toDouble(),
    );

Map<String, dynamic> _$FeelsLikeModelToJson(FeelsLikeModel instance) =>
    <String, dynamic>{
      'day': instance.day,
      'night': instance.night,
      'eve': instance.eve,
      'morn': instance.morn,
    };

WeatherConditionModel _$WeatherConditionModelFromJson(
        Map<String, dynamic> json) =>
    WeatherConditionModel(
      id: (json['id'] as num).toInt(),
      main: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$WeatherConditionModelToJson(
        WeatherConditionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };
