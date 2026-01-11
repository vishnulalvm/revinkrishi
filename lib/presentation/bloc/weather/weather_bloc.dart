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
    emit(const WeatherLoading());

    final result = await repository.getWeatherByCurrentLocation();

    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (weather) => emit(WeatherLoaded(weather)),
    );
  }

  Future<void> _onFetchWeatherByCoordinates(
    FetchWeatherByCoordinates event,
    Emitter<WeatherState> emit,
  ) async {
    emit(const WeatherLoading());

    final result = await repository.getWeather(
      lat: event.lat,
      lon: event.lon,
    );

    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (weather) => emit(WeatherLoaded(weather)),
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
