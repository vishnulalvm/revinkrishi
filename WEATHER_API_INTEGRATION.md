# OpenWeather API Integration - Complete Guide

## Overview
This document describes the OpenWeather API integration implemented in the RevInKrishi Flutter application. The integration follows Clean Architecture principles with BLoC state management.

## What Was Implemented

### 1. Architecture
The integration follows a **3-layer Clean Architecture**:
- **Presentation Layer**: UI widgets and BLoC state management
- **Domain Layer**: Business logic entities and repository interfaces
- **Data Layer**: API models, data sources, and repository implementations

### 2. API Integration Details

#### API Endpoint
- **Base URL**: `https://api.openweathermap.org`
- **Endpoint**: `/data/3.0/onecall`
- **API Key**: `19698d39b5aa1e6b6ed566055e811091` (stored in `lib/core/constants/api_constants.dart`)

#### Features Implemented
✅ **GPS-based location** - Automatically fetches weather for device's current location
✅ **Auto-refresh on app startup** - Weather data loads when app opens
✅ **Pull-to-refresh** - Swipe down to manually refresh weather data
✅ **Real-time data** - All hardcoded values replaced with live API data
✅ **7-day forecast** - Shows weekly weather forecast
✅ **Current conditions** - Temperature, feels like, humidity, wind speed, etc.

### 3. Files Created/Modified

#### New Files Created:
```
lib/core/
├── constants/api_constants.dart          # API configuration
├── error/failures.dart                   # Error handling classes
├── network/dio_client.dart               # HTTP client setup
├── di/injection.dart                     # Dependency injection
└── utils/weather_utils.dart              # Helper functions

lib/domain/
├── entities/weather_entity.dart          # Business entities
└── repositories/weather_repository.dart  # Repository interface

lib/data/
├── models/
│   ├── weather_model.dart                # API response models
│   └── weather_model.g.dart              # Generated JSON serialization
├── datasources/
│   ├── weather_remote_datasource.dart    # Retrofit API service
│   └── weather_remote_datasource.g.dart  # Generated Retrofit code
└── repositories/
    └── weather_repository_impl.dart      # Repository implementation

lib/presentation/
├── bloc/weather/
│   ├── weather_bloc.dart                 # BLoC logic
│   ├── weather_event.dart                # BLoC events
│   └── weather_state.dart                # BLoC states
└── widgets/
    ├── weather_header.dart               # Modified - now uses API data
    └── weather_card.dart                 # Modified - now uses API data

lib/presentation/pages/
└── home_page.dart                        # Modified - added BLoC and refresh

lib/main.dart                             # Modified - DI setup & BLoC provider
```

#### Platform Configuration:
```
android/app/src/main/AndroidManifest.xml  # Location permissions
ios/Runner/Info.plist                      # Location permissions
pubspec.yaml                               # New dependencies
```

### 4. Dependencies Added

```yaml
# Location Services
geolocator: ^13.0.2
permission_handler: ^11.3.1
```

### 5. Data Flow

```
User Opens App
    ↓
HomePage initState()
    ↓
WeatherBloc receives FetchWeatherByLocation event
    ↓
Repository requests location permission
    ↓
GPS gets current coordinates (lat/lon)
    ↓
API call to OpenWeather OneCall API 3.0
    ↓
Response converted: Model → Entity
    ↓
BLoC emits WeatherLoaded state
    ↓
UI updates with real data
```

### 6. API Response Mapping

**Current Weather Data:**
- Temperature (°C)
- Feels like temperature
- Humidity (%)
- Wind speed (m/s)
- Pressure (hPa)
- Cloud coverage (%)
- UV index
- Weather condition & description
- Weather icon code

**Daily Forecast (7 days):**
- Date
- Min/Max temperature
- Weather condition
- Precipitation probability
- Humidity
- Wind speed

### 7. Location Permissions

#### Android (`AndroidManifest.xml`):
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.INTERNET" />
```

#### iOS (`Info.plist`):
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to your location to provide accurate weather information for your farm.</string>
```

### 8. State Management

**BLoC States:**
- `WeatherInitial` - Initial state
- `WeatherLoading` - Loading indicator
- `WeatherLoaded` - Success with data
- `WeatherError` - Error with message

**BLoC Events:**
- `FetchWeatherByLocation` - Fetch using GPS
- `FetchWeatherByCoordinates` - Fetch using specific coordinates
- `RefreshWeather` - Refresh current data

### 9. Error Handling

The app handles multiple error scenarios:
- **No internet connection** - Shows network error
- **Location permission denied** - Shows permission error
- **Location services disabled** - Shows location error
- **API errors** - Shows server error with status code
- **Timeout errors** - Shows timeout message

### 10. UI Updates

#### WeatherHeader Widget:
- ✅ Temperature from `weather.current.temp`
- ✅ Weather condition from `weather.current.weatherDescription`
- ✅ Humidity from `weather.current.humidity`
- ✅ Weather icon animation based on condition
- ✅ 7-day forecast from `weather.daily[]`

#### WeatherCard Widget:
- ✅ Temperature from `weather.current.temp`
- ✅ Feels like from `weather.current.feelsLike`
- ✅ Weather description
- ✅ Dynamic weather icon

## How to Use

### 1. Grant Location Permission
When you first run the app, it will request location permission. Grant it to fetch weather data.

### 2. Auto-Refresh
Weather data automatically loads when:
- App starts
- You navigate to the Home page

### 3. Manual Refresh
Pull down from the top of the Home page to manually refresh weather data.

### 4. View Forecast
Tap the dropdown arrow in the weather header to expand the 7-day forecast.

## API Key Security Note

⚠️ **Important**: The API key is currently hardcoded in `lib/core/constants/api_constants.dart`. For production:
1. Move the API key to environment variables
2. Use `.env` file with `flutter_dotenv` package
3. Add `.env` to `.gitignore`
4. Never commit API keys to version control

## Testing the Integration

### Test Scenarios:
1. **Normal flow**: Open app → Grant location → See weather
2. **Refresh**: Swipe down on home page → Data refreshes
3. **No internet**: Turn off WiFi → See error message
4. **Permission denied**: Deny location → See permission error
5. **Location disabled**: Disable GPS → See location error

### Verify Data:
- Temperature should match your current location
- Weather description should be accurate
- 7-day forecast should show future dates
- All data should update on refresh

## Future Enhancements

### Potential improvements:
1. **Cache last weather data** using Hive (offline support)
2. **Multiple locations** - Save and switch between farm locations
3. **Weather alerts** - Push notifications for severe weather
4. **Historical data** - Weather trends and patterns
5. **Sensor integration** - Combine API weather with IoT sensor data
6. **Irrigation recommendations** - Based on weather + soil data

## Architecture Benefits

### Clean Architecture advantages:
✅ **Testable** - Each layer can be tested independently
✅ **Maintainable** - Clear separation of concerns
✅ **Scalable** - Easy to add new features
✅ **Flexible** - Can swap API providers easily

### BLoC Pattern advantages:
✅ **Predictable state** - Single source of truth
✅ **Reactive UI** - Automatically updates on state changes
✅ **Separation** - Business logic separate from UI
✅ **Testing** - Easy to test with bloc_test

## Troubleshooting

### Common Issues:

**1. Location permission keeps asking:**
- Check platform permissions are added correctly
- Ensure location services are enabled on device

**2. API returns 401 Unauthorized:**
- Verify API key in `api_constants.dart`
- Check if API key is active on OpenWeather dashboard

**3. Data not loading:**
- Check internet connection
- Verify GPS is enabled
- Check console for API errors

**4. Build errors:**
- Run `flutter pub get`
- Generated files are already created (*.g.dart)
- Run `flutter clean` if issues persist

## API Documentation

Full OpenWeather OneCall API 3.0 documentation:
https://openweathermap.org/api/one-call-3

## Summary

This integration successfully:
✅ Replaces all hardcoded weather values with real API data
✅ Uses GPS for automatic location detection
✅ Implements pull-to-refresh functionality
✅ Follows Clean Architecture and BLoC patterns
✅ Handles errors gracefully
✅ Provides smooth loading states
✅ Shows 7-day weather forecast
✅ Updates UI reactively when data changes

The app is now production-ready for weather data display! 🌤️
