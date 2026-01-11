import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final CurrentWeather current;
  final List<DailyWeather> daily;

  const WeatherEntity({
    required this.current,
    required this.daily,
  });

  @override
  List<Object?> get props => [current, daily];
}

class CurrentWeather extends Equatable {
  final double temp;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final int clouds;
  final int uvi;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;

  const CurrentWeather({
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.clouds,
    required this.uvi,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
  });

  @override
  List<Object?> get props => [
        temp,
        feelsLike,
        humidity,
        windSpeed,
        pressure,
        clouds,
        uvi,
        weatherMain,
        weatherDescription,
        weatherIcon,
      ];
}

class DailyWeather extends Equatable {
  final DateTime date;
  final double tempMax;
  final double tempMin;
  final int pop; // Probability of precipitation (0-100)
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;
  final int humidity;
  final double windSpeed;

  const DailyWeather({
    required this.date,
    required this.tempMax,
    required this.tempMin,
    required this.pop,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.humidity,
    required this.windSpeed,
  });

  @override
  List<Object?> get props => [
        date,
        tempMax,
        tempMin,
        pop,
        weatherMain,
        weatherDescription,
        weatherIcon,
        humidity,
        windSpeed,
      ];
}
