import 'package:flutter/material.dart';

/// Agriculture-themed color palette with professional UI/UX standards
/// Supports both light and dark modes with proper contrast ratios (WCAG AA compliant)
class AppColors {
  // ==================== LIGHT THEME ====================

  // Primary Colors - Fresh Green (Agriculture/Growth theme)
  static const Color lightPrimary = Color(0xFF4CAF50); // Fresh grass green
  static const Color lightPrimaryDark = Color(0xFF388E3C); // Darker shade
  static const Color lightPrimaryLight = Color(0xFF81C784); // Lighter shade

  // Secondary Colors - Earthy Brown (Soil theme)
  static const Color lightSecondary = Color(0xFF795548); // Rich soil brown
  static const Color lightSecondaryLight = Color(0xFFA1887F);

  // Background & Surface
  static const Color lightBackground = Color(0xFFF1F8F4); // Very light mint green
  static const Color lightSurface = Color(0xFFFFFFFF); // Pure white
  static const Color lightCardBackground = Color(0xFFFFFFFF); // White cards

  // Text Colors
  static const Color lightText = Color(0xFF1C1C1C); // Almost black for readability
  static const Color lightTextSecondary = Color(0xFF5F6368); // Medium grey
  static const Color lightTextTertiary = Color(0xFF80868B); // Light grey

  // Accent Color
  static const Color lightAccent = Color(0xFF8BC34A); // Light lime green


  // ==================== DARK THEME ====================

  // Primary Colors
  static const Color darkPrimary = Color(0xFF66BB6A); // Lighter green for dark bg
  static const Color darkPrimaryDark = Color(0xFF4CAF50);
  static const Color darkPrimaryLight = Color(0xFF81C784);

  // Secondary Colors
  static const Color darkSecondary = Color(0xFFA1887F); // Light brown for contrast
  static const Color darkSecondaryLight = Color(0xFFBCAAA4);

  // Background & Surface
  static const Color darkBackground = Color(0xFF121212); // True dark background
  static const Color darkSurface = Color(0xFF1E1E1E); // Elevated surface
  static const Color darkCardBackground = Color(0xFF2C2C2C); // Card background

  // Text Colors
  static const Color darkText = Color(0xFFE1E3E1); // Off-white for readability
  static const Color darkTextSecondary = Color(0xFFB0B3B0); // Medium grey
  static const Color darkTextTertiary = Color(0xFF6F716F); // Dark grey

  // Accent Color
  static const Color darkAccent = Color(0xFF8BC34A); // Light lime green


  // ==================== SEMANTIC COLORS ====================

  // Success (Growth, Healthy)
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF81C784);
  static const Color successDark = Color(0xFF388E3C);

  // Warning (Attention needed)
  static const Color warning = Color(0xFFFFA726);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color warningDark = Color(0xFFF57C00);

  // Error (Critical issues)
  static const Color error = Color(0xFFE53935);
  static const Color errorLight = Color(0xFFEF5350);
  static const Color errorDark = Color(0xFFC62828);

  // Info (Information)
  static const Color info = Color(0xFF29B6F6);
  static const Color infoLight = Color(0xFF4FC3F7);
  static const Color infoDark = Color(0xFF0288D1);


  // ==================== FUNCTIONAL COLORS ====================

  // Sensor & Metrics Colors
  static const Color moistureColor = Color(0xFF2196F3); // Blue - water
  static const Color humidityColor = Color(0xFF00BCD4); // Cyan - humidity
  static const Color temperatureColor = Color(0xFFFF5722); // Orange - heat
  static const Color nitrogenColor = Color(0xFFFFEB3B); // Yellow - nutrients
  static const Color phColor = Color(0xFF9C27B0); // Purple - pH levels

  // Task Colors
  static const Color irrigationColor = Color(0xFF2196F3); // Blue
  static const Color fertigationColor = Color(0xFFFF9800); // Orange
  static const Color pestControlColor = Color(0xFFE53935); // Red
  static const Color soilAnalysisColor = Color(0xFF795548); // Brown
  static const Color harvestColor = Color(0xFF4CAF50); // Green
  static const Color plantingColor = Color(0xFF8BC34A); // Light green


  // ==================== NEUTRAL COLORS ====================

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Grey Scale
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);


  // ==================== GRADIENTS ====================

  // Light mode gradient - Fresh growth
  static const LinearGradient lightGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF66BB6A), Color(0xFF4CAF50)],
  );

  // Dark mode gradient - Night field
  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF388E3C), Color(0xFF2E7D32)],
  );

  // Weather gradient - Sky
  static const LinearGradient weatherGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7CB342), Color(0xFF558B2F)],
  );

  // Sunset gradient - Warm
  static const LinearGradient sunsetGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFB74D), Color(0xFFFF9800)],
  );
}
