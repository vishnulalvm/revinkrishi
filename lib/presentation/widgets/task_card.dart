import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/themes/app_colors.dart';

class TaskCard extends StatefulWidget {
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
  final VoidCallback? onFinish;
  final VoidCallback? onCancel;
  final bool isFirst;
  final bool isLast;

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
    this.onFinish,
    this.onCancel,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        if (widget.onTap != null) {
          widget.onTap!();
        }
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: widget.isLast
                ? BorderSide.none
                : BorderSide(
                    color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
                    width: 8,
                  ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with icon, title, and priority
            Row(
              children: [
                // Icon with gradient background
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        widget.iconColor.withValues(alpha: 0.2),
                        widget.iconColor.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    widget.icon,
                    color: widget.iconColor,
                    size: 22.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                // Title and subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.darkText : AppColors.lightText,
                          decoration: widget.isCompleted ? TextDecoration.lineThrough : null,
                          decorationColor: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        widget.subtitle,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Priority badge or action button
                if (widget.priorityLabel != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: widget.priorityColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      widget.priorityLabel!,
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.bold,
                        color: widget.priorityColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                  )
                else if (widget.showToggle)
                  GestureDetector(
                    onTap: widget.onToggle != null
                        ? () {
                            HapticFeedback.mediumImpact();
                            widget.onToggle!();
                          }
                        : null,
                    child: Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: BoxDecoration(
                        color: widget.isCompleted
                            ? AppColors.success
                            : Colors.transparent,
                        border: Border.all(
                          color: widget.isCompleted
                              ? AppColors.success
                              : (isDark ? AppColors.grey600 : AppColors.grey400),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: widget.isCompleted
                          ? Icon(
                              Icons.check,
                              size: 16.sp,
                              color: AppColors.white,
                            )
                          : null,
                    ),
                  ),
              ],
            ),

            SizedBox(height: 8.h),

            // Footer with time and duration
            Row(
              children: [
                // Time
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.grey800.withValues(alpha: 0.5)
                        : AppColors.grey100,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 13.sp,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        widget.time,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                // Duration
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.grey800.withValues(alpha: 0.5)
                        : AppColors.grey100,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 13.sp,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        widget.duration,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Status indicator
                if (widget.isCompleted)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 12.sp,
                          color: AppColors.success,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),

            // Expandable action buttons
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _isExpanded
                  ? Column(
                      children: [
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            // Finish button
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  HapticFeedback.mediumImpact();
                                  if (widget.onFinish != null) {
                                    widget.onFinish!();
                                  }
                                  setState(() {
                                    _isExpanded = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
                                  foregroundColor: isDark ? AppColors.black : AppColors.white,
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  elevation: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.check_circle, size: 18.sp),
                                    SizedBox(width: 6.w),
                                    Text(
                                      'Finish',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            // Cancel button
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  HapticFeedback.mediumImpact();
                                  if (widget.onCancel != null) {
                                    widget.onCancel!();
                                  }
                                  setState(() {
                                    _isExpanded = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isDark ? AppColors.grey700 : AppColors.grey300,
                                  foregroundColor: isDark ? AppColors.darkText : AppColors.lightText,
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  elevation: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.close, size: 18.sp),
                                    SizedBox(width: 6.w),
                                    Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
