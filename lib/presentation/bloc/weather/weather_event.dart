import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class FetchWeatherByLocation extends WeatherEvent {
  const FetchWeatherByLocation();
}

class FetchWeatherByCoordinates extends WeatherEvent {
  final double lat;
  final double lon;

  const FetchWeatherByCoordinates({
    required this.lat,
    required this.lon,
  });

  @override
  List<Object?> get props => [lat, lon];
}

class RefreshWeather extends WeatherEvent {
  const RefreshWeather();
}
