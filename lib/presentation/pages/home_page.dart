import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/weather_header.dart';
import '../widgets/sensor_card.dart';
import '../widgets/nitrogen_card.dart';
import '../widgets/crop_health_card.dart';
import '../widgets/quick_action_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Combined Weather Header (App Bar + Weather Card)
            const WeatherHeader(),

            SizedBox(height: 16.h),

            // Quick Action Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: QuickActionButton(
                      label: 'Irrigation',
                      icon: Icons.water_drop,
                      color: Colors.blue,
                      onTap: () {},
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: QuickActionButton(
                      label: 'Fertigation',
                      icon: Icons.opacity,
                      color: Colors.orange,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),

            // Field Sensors Section
            Padding(
              padding: EdgeInsets.only(top: 6.h, left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Field Sensors',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View Report',
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge?.copyWith(color: Colors.green),
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

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
