import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/themes/app_colors.dart';

class SoilPhCard extends StatelessWidget {
  const SoilPhCard({super.key});

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
                  color: Colors.purple.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.science_outlined,
                  color: Colors.purple,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                'Soil pH',
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                '6.5',
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
                'pH Level',
                style: TextStyle(
                  color: tertiaryTextColor,
                  fontSize: 12.sp,
                ),
              ),
              const Spacer(),
              Text(
                'Optimal',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // pH Scale Bar
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Acidic',
                    style: TextStyle(
                      color: tertiaryTextColor,
                      fontSize: 10.sp,
                    ),
                  ),
                  Text(
                    'Neutral',
                    style: TextStyle(
                      color: tertiaryTextColor,
                      fontSize: 10.sp,
                    ),
                  ),
                  Text(
                    'Alkaline',
                    style: TextStyle(
                      color: tertiaryTextColor,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Stack(
                children: [
                  // pH Scale gradient bar
                  Container(
                    height: 8.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      gradient: const LinearGradient(
                        colors: [
                          Colors.red,
                          Colors.orange,
                          Colors.yellow,
                          Colors.green,
                          Colors.lightGreen,
                          Colors.cyan,
                          Colors.blue,
                        ],
                      ),
                    ),
                  ),
                  // Current pH indicator
                  Positioned(
                    left: (6.5 / 14) * MediaQuery.of(context).size.width * 0.8,
                    top: -2.h,
                    child: Container(
                      width: 4.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: textColor,
                        borderRadius: BorderRadius.circular(2.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '0',
                    style: TextStyle(
                      color: tertiaryTextColor,
                      fontSize: 10.sp,
                    ),
                  ),
                  Text(
                    '7',
                    style: TextStyle(
                      color: tertiaryTextColor,
                      fontSize: 10.sp,
                    ),
                  ),
                  Text(
                    '14',
                    style: TextStyle(
                      color: tertiaryTextColor,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Recommendation
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 16.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Ideal for most crops',
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
