import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String? priorityLabel;
  final Color priorityColor;
  final String subtitle;
  final String time;
  final String duration;
  final IconData icon;
  final Color iconColor;
  final Color borderColor;
  final bool isCompleted;
  final bool showToggle;
  final VoidCallback? onTap;
  final VoidCallback? onToggle;

  const TaskCard({
    super.key,
    required this.title,
    this.priorityLabel,
    required this.priorityColor,
    required this.subtitle,
    required this.time,
    required this.duration,
    required this.icon,
    required this.iconColor,
    required this.borderColor,
    this.isCompleted = false,
    this.showToggle = false,
    this.onTap,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A2F0F) : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Left colored border
            Container(
              width: 6.w,
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  bottomLeft: Radius.circular(20.r),
                ),
              ),
            ),
            // Main content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  children: [
                    // Icon
                    Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                        color: iconColor.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
                        color: iconColor,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Task details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white : Colors.black87,
                                  ),
                                ),
                              ),
                              if (priorityLabel != null) ...[
                                SizedBox(width: 8.w),
                                Text(
                                  priorityLabel!,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                    color: priorityColor,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 6.h),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 14.sp,
                                color: isDark ? Colors.white60 : Colors.black45,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '$time • $duration',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: isDark ? Colors.white60 : Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    // Action button (toggle or play)
                    if (showToggle)
                      GestureDetector(
                        onTap: onToggle,
                        child: Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: BoxDecoration(
                            color: isCompleted
                                ? Colors.grey.shade300
                                : Colors.grey.shade200,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isCompleted ? Icons.check : null,
                            color: isCompleted ? Colors.grey.shade600 : null,
                            size: 20.sp,
                          ),
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: onTap,
                        child: Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.black54,
                            size: 24.sp,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
