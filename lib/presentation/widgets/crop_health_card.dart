import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/themes/app_colors.dart';

class CropHealthCard extends StatelessWidget {
  const CropHealthCard({super.key});

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
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.eco_outlined,
                  color: Colors.green,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                'Crop Health',
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                '85%',
                style: TextStyle(
                  color: textColor,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Text(
                'Overall analysis',
                style: TextStyle(
                  color: tertiaryTextColor,
                  fontSize: 12.sp,
                ),
              ),
              const Spacer(),
              Text(
                'Good Status',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: 0.85,
              minHeight: 8.h,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
