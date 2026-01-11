import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/weather/weather_bloc.dart';
import '../bloc/weather/weather_event.dart';
import '../bloc/weather/weather_state.dart';
import '../widgets/weather_header.dart';
import '../widgets/sensor_card.dart';
import '../widgets/nitrogen_card.dart';
import '../widgets/crop_health_card.dart';
import '../widgets/quick_action_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Fetch weather on page load
    context.read<WeatherBloc>().add(const FetchWeatherByLocation());
  }

  Future<void> _onRefresh() async {
    context.read<WeatherBloc>().add(const RefreshWeather());
    // Wait a bit for the refresh to complete
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
              child: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  // Get humidity from weather API if available
                  final humidity = state is WeatherLoaded
                      ? state.weather.current.humidity
                      : null;

                  // Calculate humidity status
                  String humidityStatus = 'Loading...';
                  if (humidity != null) {
                    if (humidity < 30) {
                      humidityStatus = 'Low';
                    } else if (humidity >= 30 && humidity <= 60) {
                      humidityStatus = 'Optimal';
                    } else {
                      humidityStatus = 'High';
                    }
                  }

                  return Row(
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
                          value: humidity != null ? '$humidity%' : '--',
                          subtitle: humidityStatus,
                          iconColor: Colors.blue,
                          chartData: humidity != null
                              ? _generateHumidityChart(humidity)
                              : const [0.5, 0.4, 0.5, 0.6, 0.5, 0.4, 0.5],
                        ),
                      ),
                    ],
                  );
                },
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
      ),
    );
  }

  // Generate dynamic chart data based on humidity level
  List<double> _generateHumidityChart(int humidity) {
    // Normalize humidity to 0.0-1.0 range
    final normalizedHumidity = humidity / 100.0;

    // Create a simulated trend chart around the current humidity value
    return [
      (normalizedHumidity - 0.1).clamp(0.0, 1.0),
      (normalizedHumidity - 0.05).clamp(0.0, 1.0),
      normalizedHumidity,
      (normalizedHumidity + 0.02).clamp(0.0, 1.0),
      (normalizedHumidity - 0.03).clamp(0.0, 1.0),
      (normalizedHumidity + 0.01).clamp(0.0, 1.0),
      normalizedHumidity,
    ];
  }
}
