import 'package:flutter/material.dart';

/// Agriculture-themed color palette with professional UI/UX standards
/// Supports both light and dark modes with proper contrast ratios (WCAG AA compliant)
class AppColors {
  // ==================== LIGHT THEME ====================

  // Primary Colors - Forest Green (Premium Agriculture)
  static const Color lightPrimary = Color(0xFF2E7D32); // Rich Forest Green
  static const Color lightPrimaryDark = Color(0xFF1B5E20); // Deep Forest Green
  static const Color lightPrimaryLight = Color(0xFF43A047); // Lighter Green

  // Secondary Colors - Earthy Taupe
  static const Color lightSecondary = Color(0xFF5D4037); // Deep Earth Brown
  static const Color lightSecondaryLight = Color(0xFF8D6E63);

  // Background & Surface
  static const Color lightBackground = Color(
    0xFFF0F8F2,
  ); // Light green touch background
  static const Color lightSurface = Color(0xFFFFFFFF); // Pure white
  static const Color lightCardBackground = Color(0xFFFFFFFF); // White cards

  // Text Colors
  static const Color lightText = Color(0xFF1A1C1A); // Soft Black
  static const Color lightTextSecondary = Color(0xFF454945); // Dark Grey-Green
  static const Color lightTextTertiary = Color(0xFF727972); // Light Grey-Green

  // Accent Color
  static const Color lightAccent = Color(0xFF66BB6A); // Vibrant Green

  // ==================== DARK THEME ====================

  // Primary Colors
  static const Color darkPrimary = Color(
    0xFF66BB6A,
  ); // Vibrant Green for Dark Mode
  static const Color darkPrimaryDark = Color(0xFF2E7D32);
  static const Color darkPrimaryLight = Color(0xFF81C784);

  // Secondary Colors
  static const Color darkSecondary = Color(
    0xFFA1887F,
  ); // Desaturated Earth Tone
  static const Color darkSecondaryLight = Color(0xFFBCAAA4);

  // Background & Surface
  static const Color darkBackground = Color(
    0xFF101410,
  ); // Very dark green-black
  static const Color darkSurface = Color(
    0xFF1C211C,
  ); // Slightly lighter dark surface
  static const Color darkCardBackground = Color(0xFF242924); // Card background

  // Text Colors
  static const Color darkText = Color(0xFFEDF2ED); // Off-white
  static const Color darkTextSecondary = Color(0xFFB0B5B0); // Light Grey
  static const Color darkTextTertiary = Color(0xFF707570); // Darker Grey

  // Accent Color
  static const Color darkAccent = Color(0xFF66BB6A);

  // ==================== SEMANTIC COLORS ====================

  // Success
  static const Color success = Color(0xFF2E7D32);
  static const Color successLight = Color(0xFF66BB6A);
  static const Color successDark = Color(0xFF1B5E20);

  // Warning
  static const Color warning = Color(0xFFF57C00);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color warningDark = Color(0xFFE65100);

  // Error
  static const Color error = Color(0xFFC62828);
  static const Color errorLight = Color(0xFFE57373);
  static const Color errorDark = Color(0xFFB71C1C);

  // Info
  static const Color info = Color(0xFF0277BD);
  static const Color infoLight = Color(0xFF4FC3F7);
  static const Color infoDark = Color(0xFF01579B);

  // ==================== FUNCTIONAL COLORS ====================

  static const Color moistureColor = Color(0xFF1976D2); // Deep Blue
  static const Color humidityColor = Color(0xFF0097A7); // Teal
  static const Color temperatureColor = Color(0xFFE64A19); // Deep Orange
  static const Color nitrogenColor = Color(0xFFFBC02D); // Rich Yellow
  static const Color phColor = Color(0xFF7B1FA2); // Purple

  // Task Colors
  static const Color irrigationColor = Color(0xFF1976D2);
  static const Color fertigationColor = Color(0xFFF57C00);
  static const Color pestControlColor = Color(0xFFD32F2F);
  static const Color soilAnalysisColor = Color(0xFF5D4037);
  static const Color harvestColor = Color(0xFF388E3C);
  static const Color plantingColor = Color(0xFF689F38);

  // ==================== NEUTRAL COLORS ====================

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE); // Restored
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD); // Restored
  static const Color grey500 = Color(0xFF9E9E9E); // Restored
  static const Color grey600 = Color(0xFF757575); // Restored
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242); // Restored
  static const Color grey900 = Color(0xFF212121);

  // ==================== GRADIENTS ====================

  // Premium Light Gradient
  static const LinearGradient lightGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2E7D32), Color(0xFF1B5E20)],
  );

  // Premium Dark Gradient
  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1B5E20), Color(0xFF0D3311)],
  );

  static const LinearGradient weatherGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF558B2F), Color(0xFF33691E)],
  );

  static const LinearGradient sunsetGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFEF6C00), Color(0xFFE65100)],
  );
}
