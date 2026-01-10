import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/weather_card.dart';
import '../widgets/sensor_card.dart';
import '../widgets/nitrogen_card.dart';
import '../widgets/crop_health_card.dart';
import '../widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppBar Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  children: [
                    Icon(
                      Icons.menu,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black87,
                      size: 28.sp,
                    ),
                    SizedBox(width: 16.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF243518)
                            : const Color(0xFF3A5A28),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Green Valley Farm',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      radius: 20.r,
                      backgroundColor: Colors.orange.shade200,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),

              // Weather Card
              const WeatherCard(),

              // Field Sensors Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Field Sensors',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'View Report',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.h),

              // Moisture and Humidity Cards
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: SensorCard(
                        icon: Icons.water_drop_outlined,
                        label: 'Moisture',
                        value: '68%',
                        subtitle: '+2%',
                        iconColor: Colors.green,
                        chartData: const [0.3, 0.5, 0.4, 0.6, 0.7, 0.5, 0.8],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: SensorCard(
                        icon: Icons.air,
                        label: 'Humidity',
                        value: '45%',
                        subtitle: 'Stable',
                        iconColor: Colors.blue,
                        chartData: const [0.5, 0.4, 0.5, 0.6, 0.5, 0.4, 0.5],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Nitrogen Levels Card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: const NitrogenCard(),
              ),

              SizedBox(height: 16.h),

              // Crop Health Card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: const CropHealthCard(),
              ),

              SizedBox(height: 16.h),

              // Scan Field Button
              ScanButton(
                onTap: () {
                  // Handle scan action
                },
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
