import 'package:flutter/material.dart';

/// Responsive utility class for handling different screen sizes
/// Provides breakpoints and helpers for tablet/mobile layouts
class ResponsiveUtils {
  // Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  /// Check if current device is mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  /// Check if current device is tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < desktopBreakpoint;
  }

  /// Check if current device is desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktopBreakpoint;
  }

  /// Check if screen width is at least tablet size
  static bool isTabletOrLarger(BuildContext context) {
    return MediaQuery.of(context).size.width >= mobileBreakpoint;
  }

  /// Get responsive value based on screen size
  static T getResponsiveValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context) && desktop != null) {
      return desktop;
    } else if (isTabletOrLarger(context) && tablet != null) {
      return tablet;
    }
    return mobile;
  }

  /// Get number of columns for grid based on screen size
  static int getGridColumns(BuildContext context, {
    int mobile = 1,
    int tablet = 2,
    int desktop = 3,
  }) {
    if (isDesktop(context)) {
      return desktop;
    } else if (isTabletOrLarger(context)) {
      return tablet;
    }
    return mobile;
  }

  /// Get horizontal padding based on screen size
  static double getHorizontalPadding(BuildContext context) {
    if (isDesktop(context)) {
      return 48.0;
    } else if (isTablet(context)) {
      return 32.0;
    }
    return 16.0;
  }

  /// Get maximum content width for centered layouts
  static double? getMaxContentWidth(BuildContext context) {
    if (isDesktop(context)) {
      return 1200.0;
    } else if (isTablet(context)) {
      return 900.0;
    }
    return null; // Full width on mobile
  }

  /// Get card width for responsive grid layouts
  static double getCardWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = getHorizontalPadding(context);
    final columns = getGridColumns(context, mobile: 1, tablet: 2, desktop: 3);

    return (screenWidth - (padding * 2) - ((columns - 1) * 16)) / columns;
  }
}

/// Responsive layout builder widget
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= ResponsiveUtils.desktopBreakpoint && desktop != null) {
          return desktop!;
        } else if (constraints.maxWidth >= ResponsiveUtils.mobileBreakpoint && tablet != null) {
          return tablet!;
        }
        return mobile;
      },
    );
  }
}

/// Widget to center and constrain content on larger screens
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? maxWidth;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final constrainedMaxWidth = maxWidth ?? ResponsiveUtils.getMaxContentWidth(context);

    if (constrainedMaxWidth != null) {
      return Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: constrainedMaxWidth),
          child: child,
        ),
      );
    }

    return child;
  }
}
