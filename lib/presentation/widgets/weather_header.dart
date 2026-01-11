import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class WeatherHeader extends StatefulWidget {
  const WeatherHeader({super.key});

  @override
  State<WeatherHeader> createState() => _WeatherHeaderState();
}

class _WeatherHeaderState extends State<WeatherHeader> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/weather.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Overall gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.3),
                  Colors.black.withValues(alpha: 0.5),
                ],
              ),
            ),
          ),
          // Bottom dark overlay for better text visibility
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 120.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.5),
                    Colors.black.withValues(alpha: 0.8),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 60.h, 12.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Farm Dropdown - Centered with dark overlay
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.6),
                          Colors.black.withValues(alpha: 0.5),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Location icon
                        Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF2E7D32),
                                const Color(0xFF43A047),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF2E7D32)
                                    .withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 12.sp,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Green Valley Farm',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                            shadows: [
                              Shadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                offset: const Offset(0, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                // Temperature with Lottie Animation
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '72°',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 52.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // const Spacer(),
                    // Lottie Weather Animation
                    Lottie.asset(
                      'assets/lottie/Weather-partly cloudy.json',
                      width: 40.w,
                      height: 40.h,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                // Weather condition and precipitation
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        'Partly Cloudy',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        '•',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Precipitation: 10%',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12.sp,
                        ),
                      ),
                      const Spacer(),
                      AnimatedRotation(
                        turns: _isExpanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                // Upcoming Weather Forecast
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: _isExpanded
                      ? Column(
                          children: [
                            SizedBox(height: 16.h),
                            SizedBox(
                              height: 70.h,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  _buildWeatherDay(
                                    'Sat',
                                    Icons.wb_sunny,
                                    '32°',
                                    '23°',
                                    true,
                                  ),
                                  _buildWeatherDay(
                                    'Sun',
                                    Icons.cloud_queue,
                                    '31°',
                                    '23°',
                                    false,
                                  ),
                                  _buildWeatherDay(
                                    'Mon',
                                    Icons.cloud_queue,
                                    '32°',
                                    '23°',
                                    false,
                                  ),
                                  _buildWeatherDay(
                                    'Tue',
                                    Icons.cloud,
                                    '32°',
                                    '23°',
                                    false,
                                  ),
                                  _buildWeatherDay(
                                    'Wed',
                                    Icons.wb_cloudy,
                                    '32°',
                                    '23°',
                                    false,
                                  ),
                                  _buildWeatherDay(
                                    'Thu',
                                    Icons.wb_cloudy,
                                    '32°',
                                    '22°',
                                    false,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDay(
    String day,
    IconData icon,
    String highTemp,
    String lowTemp,
    bool isSelected,
  ) {
    return Container(
      width: 65.w,
      height: 70.h,
      margin: EdgeInsets.only(right: 8.w),
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.white.withValues(alpha: 0.25)
            : Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.4)
              : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            day,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3.h),
          Icon(
            icon,
            color: Colors.white,
            size: 20.sp,
          ),
          SizedBox(height: 3.h),
          Text(
            '$highTemp/$lowTemp',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
