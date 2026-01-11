import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/themes/app_colors.dart';
import '../widgets/task_card.dart';
import '../../core/utils/responsive_utils.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final bool _showPending = true;
  bool _isWeekViewExpanded = false;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final horizontalPadding = ResponsiveUtils.getHorizontalPadding(context);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Schedule',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,

          ),
        ),
      ),
      body: SafeArea(
        child: ResponsiveContainer(
          child: Column(
            children: [

              // Week View Bar
              _buildWeekViewBar(isDark),


              SizedBox(height: 16.h),

              // Tasks List
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Today's Tasks Section
                    _buildTaskSection(
                      isDark,
                      'TODAY, OCT 24',
                      '3 Tasks',
                      _showPending
                          ? [
                              TaskCard(
                                title: 'Irrigation',
                                priorityLabel: 'HIGH PRIORITY',
                                priorityColor: Colors.blue,
                                subtitle: 'Sector 7 - Tomatoes',
                                time: '08:00 AM',
                                duration: '45 mins',
                                icon: Icons.water_drop,
                                iconColor: Colors.blue,
                                borderColor: Colors.blue,
                                onTap: () {},
                              ),
                              TaskCard(
                                title: 'Fertigation',
                                priorityLabel: null,
                                priorityColor: Colors.orange,
                                subtitle: 'Greenhouse B - Strawberri...',
                                time: '10:30 AM',
                                duration: '1h 20m',
                                icon: Icons.opacity,
                                iconColor: Colors.orange,
                                borderColor: Colors.orange,
                                onTap: () {},
                              ),
                              TaskCard(
                                title: 'Pest Control',
                                priorityLabel: 'WARNING',
                                priorityColor: Colors.red,
                                subtitle: 'Orchard Row 4',
                                time: '02:00 PM',
                                duration: 'Manual Check',
                                icon: Icons.bug_report,
                                iconColor: Colors.red,
                                borderColor: Colors.red,
                                showToggle: true,
                                onToggle: () {},
                              ),
                            ]
                          : [
                              TaskCard(
                                title: 'Harvesting',
                                priorityLabel: null,
                                priorityColor: Colors.green,
                                subtitle: 'Field A - Wheat',
                                time: '06:00 AM',
                                duration: '2h 30m',
                                icon: Icons.agriculture,
                                iconColor: Colors.green,
                                borderColor: Colors.green,
                                isCompleted: true,
                                showToggle: true,
                                onToggle: () {},
                              ),
                              TaskCard(
                                title: 'Fertilizer Application',
                                priorityLabel: null,
                                priorityColor: Colors.brown,
                                subtitle: 'Sector 3 - Corn',
                                time: '09:00 AM',
                                duration: '1h 15m',
                                icon: Icons.local_florist,
                                iconColor: Colors.brown,
                                borderColor: Colors.brown,
                                isCompleted: true,
                                showToggle: true,
                                onToggle: () {},
                              ),
                            ],
                    ),

                    SizedBox(height: 16.h),

                    // Tomorrow's Tasks Section
                    _buildTaskSection(
                      isDark,
                      'TOMORROW, OCT 25',
                      '1 Task',
                      [
                        TaskCard(
                          title: 'Soil Analysis',
                          priorityLabel: null,
                          priorityColor: Colors.grey,
                          subtitle: 'Fields 3 & 4',
                          time: '04:30 PM',
                          duration: 'Pending',
                          icon: Icons.science,
                          iconColor: Colors.grey,
                          borderColor: Colors.grey,
                          onTap: () {},
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedback.mediumImpact();
          // TODO: Implement add task functionality
        },
        backgroundColor: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
        child: Icon(
          Icons.add,
          color: isDark ? AppColors.black : AppColors.white,
          size: 28.sp,
        ),
      ),
    );
  }

  Widget _buildWeekViewBar(bool isDark) {
    // Get current week dates
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final weekDates = List.generate(7, (index) => startOfWeek.add(Duration(days: index)));

    return Column(
      children: [
        // Week calendar with expand icon
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.white,
            // borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: weekDates.map((date) {
                  final isSelected = date.day == _selectedDate.day &&
                      date.month == _selectedDate.month &&
                      date.year == _selectedDate.year;
                  final isToday = date.day == now.day &&
                      date.month == now.month &&
                      date.year == now.year;

                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      setState(() {
                        _selectedDate = date;
                      });
                    },
                    child: Container(
                      width: 44.w,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.lightAccent
                            : isToday
                                ? (isDark ? AppColors.darkSurface : AppColors.grey200)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _getWeekdayShort(date.weekday),
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? AppColors.black
                                  : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '${date.day}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? AppColors.black
                                  : (isDark ? AppColors.darkText : AppColors.lightText),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              // SizedBox(height: 8.h),
              // Expand/Collapse icon
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  setState(() {
                    _isWeekViewExpanded = !_isWeekViewExpanded;
                  });
                },
                child: Icon(
                  _isWeekViewExpanded ? Icons.expand_less : Icons.expand_more,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  size: 20.sp,
                ),
              ),
            ],
          ),
        ),

        // Expandable full month calendar
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: _isWeekViewExpanded ? 280.h : 0,
          child: _isWeekViewExpanded
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCardBackground : AppColors.grey100,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: _buildFullCalendar(isDark),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildFullCalendar(bool isDark) {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
    final lastDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;
    final startWeekday = firstDayOfMonth.weekday;

    // Calculate days to show (including leading days from previous month)
    final List<DateTime?> calendarDays = [];

    // Add leading empty days
    for (int i = 1; i < startWeekday; i++) {
      calendarDays.add(null);
    }

    // Add days of current month
    for (int day = 1; day <= daysInMonth; day++) {
      calendarDays.add(DateTime(_selectedDate.year, _selectedDate.month, day));
    }

    return Column(
      children: [
        // Month and Year header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.chevron_left, color: isDark ? AppColors.darkText : AppColors.lightText),
              onPressed: () {
                HapticFeedback.lightImpact();
                setState(() {
                  _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1, 1);
                });
              },
            ),
            Text(
              '${_getMonthNameFull(_selectedDate.month)} ${_selectedDate.year}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.darkText : AppColors.lightText,
              ),
            ),
            IconButton(
              icon: Icon(Icons.chevron_right, color: isDark ? AppColors.darkText : AppColors.lightText),
              onPressed: () {
                HapticFeedback.lightImpact();
                setState(() {
                  _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1, 1);
                });
              },
            ),
          ],
        ),
        SizedBox(height: 12.h),

        // Weekday headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['M', 'T', 'W', 'T', 'F', 'S', 'S'].map((day) {
            return SizedBox(
              width: 36.w,
              child: Center(
                child: Text(
                  day,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 8.h),

        // Calendar grid
        Expanded(
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: calendarDays.length,
            itemBuilder: (context, index) {
              final date = calendarDays[index];
              if (date == null) {
                return const SizedBox.shrink();
              }

              final isSelected = date.day == _selectedDate.day &&
                  date.month == _selectedDate.month &&
                  date.year == _selectedDate.year;
              final isToday = date.day == now.day &&
                  date.month == now.month &&
                  date.year == now.year;

              return GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  setState(() {
                    _selectedDate = date;
                  });
                },
                child: Container(
                  margin: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.lightAccent
                        : isToday
                            ? (isDark ? AppColors.darkSurface : AppColors.grey200)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(
                      '${date.day}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: isSelected || isToday ? FontWeight.bold : FontWeight.normal,
                        color: isSelected
                            ? AppColors.black
                            : (isDark ? AppColors.darkText : AppColors.lightText),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _getMonthNameFull(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  String _getWeekdayShort(int weekday) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[weekday - 1];
  }

  Widget _buildTaskSection(
    bool isDark,
    String dateLabel,
    String taskCount,
    List<TaskCard> tasks,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title with Count
        Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateLabel,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),
              Text(
                taskCount,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                ),
              ),
            ],
          ),
        ),
        // Tasks Container
        Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCardBackground : AppColors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            children: tasks
                .asMap()
                .entries
                .map(
                  (entry) => TaskCard(
                    key: entry.value.key,
                    title: entry.value.title,
                    priorityLabel: entry.value.priorityLabel,
                    priorityColor: entry.value.priorityColor,
                    subtitle: entry.value.subtitle,
                    time: entry.value.time,
                    duration: entry.value.duration,
                    icon: entry.value.icon,
                    iconColor: entry.value.iconColor,
                    borderColor: entry.value.borderColor,
                    isCompleted: entry.value.isCompleted,
                    showToggle: entry.value.showToggle,
                    onTap: entry.value.onTap,
                    onToggle: entry.value.onToggle,
                    isFirst: entry.key == 0,
                    isLast: entry.key == tasks.length - 1,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
