import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/themes/app_colors.dart';

class NitrogenCard extends StatelessWidget {
  const NitrogenCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkCardBackground : AppColors.lightCardBackground;
    final textColor = isDark ? Colors.white : AppColors.lightText;
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
      child: Row(
        children: [
          // Left Side - Icon and Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.science_outlined,
                        color: Colors.orange,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Nitrogen Levels',
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  'Optimal',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'N-P-K',
                  style: TextStyle(
                    color: tertiaryTextColor,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          // Right Side - Bar Chart
          SizedBox(
            width: 100.w,
            height: 80.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar(0.5, Colors.grey),
                _buildBar(0.6, Colors.grey),
                _buildBar(0.9, Colors.green),
                _buildBar(0.7, Colors.grey),
                _buildBar(0.4, Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(double height, Color color) {
    return Container(
      width: 12.w,
      height: 80.h * height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}
