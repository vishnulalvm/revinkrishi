import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/themes/app_colors.dart';
import 'dart:math' as math;

class CropTestCard extends StatelessWidget {
  final String cropName;
  final String fieldId;
  final String lastSync;
  final int batteryLevel;
  final String currentStage; // 'sowing', 'germination', or 'growing'
  final double? temperature;
  final int? humidity;
  final double soilMoisture;

  const CropTestCard({
    super.key,
    required this.cropName,
    required this.fieldId,
    required this.lastSync,
    required this.batteryLevel,
    required this.currentStage,
    this.temperature,
    this.humidity,
    this.soilMoisture = 41.0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkCardBackground : AppColors.lightCardBackground;
    final secondaryTextColor = isDark ? Colors.white70 : AppColors.lightTextSecondary;
    final tertiaryTextColor = isDark ? Colors.white60 : AppColors.lightTextTertiary;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Crop Name with Icon
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.eco,
                      color: Colors.green,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    cropName,
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              // Crop Type Button
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Text(
                      'View',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.green,
                      size: 16.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Field ID
          Text(
            fieldId,
            style: TextStyle(
              color: tertiaryTextColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 8.h),

          // Last Sync and Battery
          Row(
            children: [
              Text(
                'Last sync: $lastSync',
                style: TextStyle(
                  color: tertiaryTextColor,
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Icon(
                Icons.battery_std,
                color: tertiaryTextColor,
                size: 14.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                '$batteryLevel%',
                style: TextStyle(
                  color: tertiaryTextColor,
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),

          // Growth Stages
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStageIndicator(
                icon: Icons.grass,
                label: 'Sowing',
                isActive: currentStage == 'sowing',
                isCompleted: _isStageCompleted('sowing'),
                isDark: isDark,
              ),
              _buildConnector(
                isCompleted: _isStageCompleted('sowing'),
                isDark: isDark,
              ),
              _buildStageIndicator(
                icon: Icons.energy_savings_leaf,
                label: 'Germination',
                isActive: currentStage == 'germination',
                isCompleted: _isStageCompleted('germination'),
                isDark: isDark,
              ),
              _buildConnector(
                isCompleted: _isStageCompleted('germination'),
                isDark: isDark,
              ),
              _buildStageIndicator(
                icon: Icons.park,
                label: 'Growing',
                isActive: currentStage == 'growing',
                isCompleted: false,
                isDark: isDark,
              ),
            ],
          ),

          SizedBox(height: 24.h),

          // Divider
          Container(
            height: 1.h,
            color: isDark
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.08),
          ),

          SizedBox(height: 24.h),

          // Sensor Readings
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCircularMetric(
                value: temperature?.toStringAsFixed(1) ?? '--',
                unit: '°C',
                label: 'Temperature',
                progress: temperature != null ? (temperature! / 50).clamp(0.0, 1.0) : 0.0,
                color: AppColors.temperatureColor,
                isDark: isDark,
                textColor: tertiaryTextColor,
              ),
              _buildCircularMetric(
                value: humidity?.toString() ?? '--',
                unit: '%',
                label: 'Humidity',
                progress: humidity != null ? (humidity! / 100).clamp(0.0, 1.0) : 0.0,
                color: AppColors.humidityColor,
                isDark: isDark,
                textColor: tertiaryTextColor,
              ),
              _buildCircularMetric(
                value: soilMoisture.toStringAsFixed(1),
                unit: '',
                label: 'Soil Moisture',
                progress: (soilMoisture / 100).clamp(0.0, 1.0),
                color: AppColors.moistureColor,
                isDark: isDark,
                textColor: tertiaryTextColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _isStageCompleted(String stage) {
    const stages = ['sowing', 'germination', 'growing'];
    final currentIndex = stages.indexOf(currentStage);
    final stageIndex = stages.indexOf(stage);
    return stageIndex < currentIndex;
  }

  Widget _buildStageIndicator({
    required IconData icon,
    required String label,
    required bool isActive,
    required bool isCompleted,
    required bool isDark,
  }) {
    final Color activeColor = const Color(0xFF8BC34A);
    final Color inactiveColor = isDark
        ? Colors.white.withValues(alpha: 0.3)
        : const Color(0xFFD1D5DB);
    final Color backgroundColor = isActive || isCompleted
        ? activeColor.withValues(alpha: 0.2)
        : inactiveColor.withValues(alpha: 0.1);

    return Column(
      children: [
        Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive || isCompleted ? activeColor : inactiveColor,
              width: isActive ? 3.w : 2.w,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                icon,
                color: isActive || isCompleted ? activeColor : inactiveColor,
                size: 28.sp,
              ),
              if (isActive)
                Positioned(
                  top: 4.h,
                  right: 4.w,
                  child: Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: activeColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: backgroundColor,
                        width: 2.w,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(
            color: isActive || isCompleted
                ? activeColor
                : (isDark ? Colors.white60 : const Color(0xFF9CA3AF)),
            fontSize: 12.sp,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildConnector({
    required bool isCompleted,
    required bool isDark,
  }) {
    return Container(
      width: 30.w,
      height: 2.h,
      margin: EdgeInsets.only(bottom: 32.h),
      color: isCompleted
          ? const Color(0xFF8BC34A)
          : (isDark ? Colors.white.withValues(alpha: 0.3) : const Color(0xFFD1D5DB)),
    );
  }

  Widget _buildCircularMetric({
    required String value,
    required String unit,
    required String label,
    required double progress,
    required Color color,
    required bool isDark,
    required Color textColor,
  }) {
    return Column(
      children: [
        SizedBox(
          width: 70.w,
          height: 70.w,
          child: CustomPaint(
            painter: _CircularProgressPainter(
              progress: progress,
              color: color,
              backgroundColor: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.08),
            ),
            child: Center(
              child: RichText(
                text: TextSpan(
                  text: value,
                  style: TextStyle(
                    color: isDark ? Colors.white : AppColors.lightText,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    if (unit.isNotEmpty)
                      TextSpan(
                        text: unit,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;

  _CircularProgressPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 5.0;

    // Background circle
    final bgPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius - strokeWidth / 2, bgPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
