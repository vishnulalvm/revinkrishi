import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/weather_utils.dart';
import '../bloc/weather/weather_bloc.dart';
import '../bloc/weather/weather_state.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoaded) {
          final weather = state.weather.current;
          return _buildWeatherCard(context, weather);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildWeatherCard(BuildContext context, currentWeather) {
    return Container(
      height: 280.h,
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF7CB342),
            Color(0xFF558B2F),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.2),
                  Colors.black.withValues(alpha: 0.4),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Live Conditions Button
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Live Conditions',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      WeatherUtils.getWeatherIcon(currentWeather.weatherIcon),
                      color: Colors.white,
                      size: 40.sp,
                    ),
                  ],
                ),
                const Spacer(),
                // Temperature
                Text(
                  WeatherUtils.formatTemp(currentWeather.temp),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 64.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                // Weather condition and precipitation
                Row(
                  children: [
                    Text(
                      WeatherUtils.capitalizeWords(
                          currentWeather.weatherDescription),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '•',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Feels like: ${WeatherUtils.formatTemp(currentWeather.feelsLike)}',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
