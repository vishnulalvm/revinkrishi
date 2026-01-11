class ApiConstants {
  ApiConstants._();

  // Base URLs
  static const String baseUrl = 'https://api.openweathermap.org';

  // API Version
  static const String apiVersion = '3.0';

  // API Key
  static const String apiKey = '19698d39b5aa1e6b6ed566055e811091';

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
