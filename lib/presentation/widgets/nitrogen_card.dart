import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NitrogenCard extends StatelessWidget {
  const NitrogenCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF243518) : const Color(0xFF3A5A28);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16.r),
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
                        color: Colors.white70,
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
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'N-P-K',
                  style: TextStyle(
                    color: Colors.white60,
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
