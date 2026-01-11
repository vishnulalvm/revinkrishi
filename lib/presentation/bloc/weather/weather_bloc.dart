import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/weather_repository.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;

  WeatherBloc({required this.repository}) : super(const WeatherInitial()) {
    on<FetchWeatherByLocation>(_onFetchWeatherByLocation);
    on<FetchWeatherByCoordinates>(_onFetchWeatherByCoordinates);
    on<RefreshWeather>(_onRefreshWeather);
  }

  Future<void> _onFetchWeatherByLocation(
    FetchWeatherByLocation event,
    Emitter<WeatherState> emit,
  ) async {
    // Try to load cached data first
    final cachedResult = await repository.getCachedWeather();

    cachedResult.fold(
      (_) {
        // No cache available, show loading
        emit(const WeatherLoading());
      },
      (cachedWeather) {
        // Show cached data immediately
        emit(WeatherLoaded(cachedWeather, isFromCache: true));
      },
    );

    // Fetch fresh data from API in background
    final result = await repository.getWeatherByCurrentLocation();

    result.fold(
      (failure) {
        // Only show error if we don't have cached data
        if (state is! WeatherLoaded) {
          emit(WeatherError(failure.message));
        }
      },
      (weather) {
        // Update with fresh data from API
        emit(WeatherLoaded(weather, isFromCache: false));
      },
    );
  }

  Future<void> _onFetchWeatherByCoordinates(
    FetchWeatherByCoordinates event,
    Emitter<WeatherState> emit,
  ) async {
    // Try to load cached data first
    final cachedResult = await repository.getCachedWeather();

    cachedResult.fold(
      (_) {
        // No cache available, show loading
        emit(const WeatherLoading());
      },
      (cachedWeather) {
        // Show cached data immediately
        emit(WeatherLoaded(cachedWeather, isFromCache: true));
      },
    );

    // Fetch fresh data from API in background
    final result = await repository.getWeather(
      lat: event.lat,
      lon: event.lon,
    );

    result.fold(
      (failure) {
        // Only show error if we don't have cached data
        if (state is! WeatherLoaded) {
          emit(WeatherError(failure.message));
        }
      },
      (weather) {
        // Update with fresh data from API
        emit(WeatherLoaded(weather, isFromCache: false));
      },
    );
  }

  Future<void> _onRefreshWeather(
    RefreshWeather event,
    Emitter<WeatherState> emit,
  ) async {
    // Don't show loading state during refresh
    final result = await repository.getWeatherByCurrentLocation();

    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (weather) => emit(WeatherLoaded(weather)),
    );
  }
}
