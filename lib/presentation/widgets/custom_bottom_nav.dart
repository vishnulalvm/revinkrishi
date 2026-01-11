import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/themes/app_colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return NavigationBarTheme(
      data: NavigationBarThemeData(
        // Icon color configuration for better visibility
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            // Selected icon: Use vibrant, high-contrast colors
            return IconThemeData(
              size: 24,
              color: isDark
                  ? AppColors.darkPrimary // Vibrant green for dark mode
                  : AppColors.lightPrimaryDark, // Deep forest green for light mode
            );
          }
          // Unselected icons: Use secondary text colors
          return IconThemeData(
            size: 24,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.darkPrimary
                  : AppColors.lightPrimaryDark,
            );
          }
          return TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          );
        }),
      ),
      child: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          HapticFeedback.selectionClick();
          onTap(index);
        },
        backgroundColor: isDark
            ? AppColors.darkSurface
            : AppColors.lightSurface,
        // Enhanced indicator with better contrast
        indicatorColor: isDark
            ? AppColors.darkPrimary.withValues(alpha: 0.15)
            : AppColors.lightPrimaryLight.withValues(alpha: 0.12),
        elevation: 2,
        height: 65,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.analytics_outlined),
            selectedIcon: Icon(Icons.analytics),
            label: 'Activity',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: 'Fields',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
