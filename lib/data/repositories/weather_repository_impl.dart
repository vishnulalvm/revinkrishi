import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import '../../core/constants/api_constants.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/local/weather_local_datasource.dart';
import '../datasources/weather_remote_datasource.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, WeatherEntity>> getWeather({
    required double lat,
    required double lon,
  }) async {
    try {
      // Fetch from API and cache the result
      final weatherModel = await remoteDataSource.getWeather(
        lat: lat,
        lon: lon,
        apiKey: ApiConstants.apiKey,
        units: ApiConstants.defaultUnits,
      );

      // Cache the fresh data
      await localDataSource.cacheWeather(weatherModel);

      return Right(weatherModel.toEntity());
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return const Left(NetworkFailure('Connection timeout'));
      } else if (e.type == DioExceptionType.connectionError) {
        return const Left(NetworkFailure('No internet connection'));
      } else if (e.response != null) {
        return Left(ServerFailure(
            'Server error: ${e.response?.statusCode ?? 'Unknown'}'));
      }
      return Left(ServerFailure('Unexpected error: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, WeatherEntity>> getWeatherByCurrentLocation() async {
    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return const Left(
              PermissionFailure('Location permissions are denied'));
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return const Left(PermissionFailure(
            'Location permissions are permanently denied'));
      }

      // Check if location service is enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return const Left(
            LocationFailure('Location services are disabled'));
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
        ),
      );

      // Fetch weather using coordinates
      return getWeather(
        lat: position.latitude,
        lon: position.longitude,
      );
    } on LocationServiceDisabledException {
      return const Left(LocationFailure('Location services are disabled'));
    } on PermissionDeniedException {
      return const Left(PermissionFailure('Location permission denied'));
    } catch (e) {
      return Left(LocationFailure('Failed to get location: $e'));
    }
  }

  @override
  Future<Either<Failure, WeatherEntity>> getCachedWeather() async {
    try {
      final cachedWeatherModel = await localDataSource.getCachedWeather();
      if (cachedWeatherModel != null) {
        return Right(cachedWeatherModel.toEntity());
      }
      return const Left(ServerFailure('No cached data available'));
    } catch (e) {
      return Left(ServerFailure('Failed to load cached data: $e'));
    }
  }
}
