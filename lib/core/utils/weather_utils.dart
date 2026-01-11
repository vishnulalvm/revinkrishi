import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherUtils {
  WeatherUtils._();

  /// Get weather icon based on OpenWeather icon code
  static IconData getWeatherIcon(String iconCode) {
    switch (iconCode) {
      // Clear sky
      case '01d':
      case '01n':
        return Icons.wb_sunny;

      // Few clouds
      case '02d':
      case '02n':
        return Icons.wb_cloudy;

      // Scattered clouds
      case '03d':
      case '03n':
        return Icons.cloud_queue;

      // Broken clouds
      case '04d':
      case '04n':
        return Icons.cloud;

      // Shower rain
      case '09d':
      case '09n':
        return Icons.grain;

      // Rain
      case '10d':
      case '10n':
        return Icons.wb_cloudy;

      // Thunderstorm
      case '11d':
      case '11n':
        return Icons.thunderstorm;

      // Snow
      case '13d':
      case '13n':
        return Icons.ac_unit;

      // Mist
      case '50d':
      case '50n':
        return Icons.blur_on;

      default:
        return Icons.wb_sunny;
    }
  }

  /// Get Lottie animation path based on weather condition
  static String getLottieAnimation(String weatherMain) {
    switch (weatherMain.toLowerCase()) {
      case 'clear':
        return 'assets/lottie/Weather-partly cloudy.json';
      case 'clouds':
        return 'assets/lottie/Weather-partly cloudy.json';
      case 'rain':
      case 'drizzle':
        return 'assets/lottie/Weather-partly cloudy.json';
      case 'thunderstorm':
        return 'assets/lottie/Weather-partly cloudy.json';
      case 'snow':
        return 'assets/lottie/Weather-partly cloudy.json';
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/lottie/Weather-partly cloudy.json';
      default:
        return 'assets/lottie/Weather-partly cloudy.json';
    }
  }

  /// Format temperature to display
  static String formatTemp(double temp) {
    return '${temp.round()}°';
  }

  /// Get day name from DateTime
  static String getDayName(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDate = DateTime(date.year, date.month, date.day);

    if (targetDate == today) {
      return 'Today';
    } else if (targetDate == today.add(const Duration(days: 1))) {
      return 'Tomorrow';
    } else {
      return DateFormat('EEE').format(date);
    }
  }

  /// Get short day name (3 letters)
  static String getShortDayName(DateTime date) {
    return DateFormat('EEE').format(date);
  }

  /// Capitalize first letter of each word
  static String capitalizeWords(String text) {
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
}
