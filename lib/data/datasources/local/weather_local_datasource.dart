import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/weather_model.dart';

abstract class WeatherLocalDataSource {
  /// Get cached weather data
  Future<WeatherModel?> getCachedWeather();

  /// Cache weather data
  Future<void> cacheWeather(WeatherModel weather);

  /// Clear cached weather data
  Future<void> clearCache();

  /// Check if cache exists
  Future<bool> hasCachedData();

  /// Get cache timestamp
  Future<DateTime?> getCacheTimestamp();
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const String _cachedWeatherKey = 'cached_weather';
  static const String _cacheTimestampKey = 'cache_timestamp';

  WeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<WeatherModel?> getCachedWeather() async {
    try {
      final jsonString = sharedPreferences.getString(_cachedWeatherKey);
      if (jsonString != null) {
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        return WeatherModel.fromJson(json);
      }
      return null;
    } catch (e) {
      // If there's any error parsing cache, return null
      return null;
    }
  }

  @override
  Future<void> cacheWeather(WeatherModel weather) async {
    try {
      final jsonString = jsonEncode(weather.toJson());
      await sharedPreferences.setString(_cachedWeatherKey, jsonString);

      // Store cache timestamp
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      await sharedPreferences.setInt(_cacheTimestampKey, timestamp);
    } catch (e) {
      // Silently fail - caching is not critical
      rethrow;
    }
  }

  @override
  Future<void> clearCache() async {
    await sharedPreferences.remove(_cachedWeatherKey);
    await sharedPreferences.remove(_cacheTimestampKey);
  }

  @override
  Future<bool> hasCachedData() async {
    return sharedPreferences.containsKey(_cachedWeatherKey);
  }

  @override
  Future<DateTime?> getCacheTimestamp() async {
    final timestamp = sharedPreferences.getInt(_cacheTimestampKey);
    if (timestamp != null) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
    return null;
  }
}
