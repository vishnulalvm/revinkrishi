import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/themes/app_colors.dart';

class SensorCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? subtitle;
  final Color iconColor;
  final List<double>? chartData;

  const SensorCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.subtitle,
    required this.iconColor,
    this.chartData,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkCardBackground : AppColors.lightCardBackground;
    final textColor = isDark ? Colors.white : AppColors.lightText;
    final secondaryTextColor = isDark ? Colors.white70 : AppColors.lightTextSecondary;

    return Container(
      padding: EdgeInsets.all(12.w),
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
          // Icon and Label
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Value
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: textColor,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subtitle != null) ...[
                SizedBox(width: 8.w),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Text(
                    subtitle!,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (chartData != null) ...[
            SizedBox(height: 16.h),
            // Simple Chart
            SizedBox(
              height: 30.h,
              child: CustomPaint(
                size: Size(double.infinity, 40.h),
                painter: SimpleCurvePainter(
                  data: chartData!,
                  color: iconColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class SimpleCurvePainter extends CustomPainter {
  final List<double> data;
  final Color color;

  SimpleCurvePainter({required this.data, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.6)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final stepWidth = size.width / (data.length - 1);

    for (int i = 0; i < data.length; i++) {
      final x = i * stepWidth;
      final y = size.height - (data[i] * size.height);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        final prevX = (i - 1) * stepWidth;
        final prevY = size.height - (data[i - 1] * size.height);
        final controlX1 = prevX + stepWidth / 2;
        final controlX2 = x - stepWidth / 2;

        path.cubicTo(controlX1, prevY, controlX2, y, x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
