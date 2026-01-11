import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getWeather({
    required double lat,
    required double lon,
  });

  Future<Either<Failure, WeatherEntity>> getWeatherByCurrentLocation();
}
