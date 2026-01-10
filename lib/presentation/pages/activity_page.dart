import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/task_card.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  bool _showPending = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // AppBar Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                children: [
                  Icon(
                    Icons.menu,
                    color: isDark ? Colors.white : Colors.black87,
                    size: 28.sp,
                  ),
                  const Spacer(),
                  Text(
                    'Schedule',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.orange.shade200,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Pending/Completed Toggle
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                height: 56.h,
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF243518)
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(28.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showPending = true;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: _showPending
                                ? const Color(0xFFB8E986)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 20.sp,
                                color: _showPending
                                    ? Colors.black87
                                    : (isDark ? Colors.white70 : Colors.black54),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Pending',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: _showPending
                                      ? Colors.black87
                                      : (isDark ? Colors.white70 : Colors.black54),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showPending = false;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: !_showPending
                                ? Colors.white
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 20.sp,
                                color: !_showPending
                                    ? Colors.black87
                                    : (isDark ? Colors.white70 : Colors.black54),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Completed',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: !_showPending
                                      ? Colors.black87
                                      : (isDark ? Colors.white70 : Colors.black54),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // Tasks List
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TODAY, OCT 24',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white70 : Colors.black54,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFB8E986),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            '3 Tasks',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Task Cards
                    if (_showPending) ...[
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
                    ] else ...[
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

                    SizedBox(height: 24.h),
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
