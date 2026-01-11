/// API Keys and Configuration Constants
/// IMPORTANT: This file contains sensitive API keys
/// Keep your API keys secure and never commit them to public repositories
class ApiConstants {
  ApiConstants._();

  // Weather API Configuration
  static const String baseUrl = 'https://api.openweathermap.org';
  static const String apiVersion = '3.0';
  static const String apiKey = '19698d39b5aa1e6b6ed566055e811091';

  // Mapbox API Configuration
  static const String mapboxAccessToken =
      'pk.eyJ1Ijoic29saWRhcHBzIiwiYSI6ImNtZGQwaXAzczAycmoyb3BzMWkyZm9pcXMifQ.B3j0rVy2fyaaljWCfGQj5Q';

  // Endpoints
  static const String oneCallEndpoint = '/data/$apiVersion/onecall';

  // Units
  static const String unitsMetric = 'metric';
  static const String unitsImperial = 'imperial';

  // Default values
  static const String defaultUnits = unitsMetric;

  // Timeout
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
