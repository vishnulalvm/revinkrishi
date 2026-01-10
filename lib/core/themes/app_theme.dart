import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: AppColors.lightBackground,

    colorScheme: const ColorScheme.light(
      primary: AppColors.lightPrimary,
      onPrimary: AppColors.white,
      secondary: AppColors.lightSecondary,
      onSecondary: AppColors.white,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightText,
      error: AppColors.error,
      onError: AppColors.white,
      tertiary: AppColors.lightAccent,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightPrimary,
      foregroundColor: AppColors.white,
      elevation: 0,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    cardTheme: CardThemeData(
      color: AppColors.lightCardBackground,
      elevation: 0,
      shadowColor: AppColors.grey300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(color: AppColors.lightText, fontWeight: FontWeight.bold, fontSize: 32),
      displayMedium: TextStyle(color: AppColors.lightText, fontWeight: FontWeight.bold, fontSize: 28),
      displaySmall: TextStyle(color: AppColors.lightText, fontWeight: FontWeight.bold, fontSize: 24),
      headlineLarge: TextStyle(color: AppColors.lightText, fontWeight: FontWeight.bold, fontSize: 20),
      headlineMedium: TextStyle(color: AppColors.lightText, fontWeight: FontWeight.w600, fontSize: 18),
      headlineSmall: TextStyle(color: AppColors.lightText, fontWeight: FontWeight.w600, fontSize: 16),
      titleLarge: TextStyle(color: AppColors.lightText, fontWeight: FontWeight.w600, fontSize: 16),
      titleMedium: TextStyle(color: AppColors.lightText, fontWeight: FontWeight.w500, fontSize: 14),
      titleSmall: TextStyle(color: AppColors.lightTextSecondary, fontWeight: FontWeight.w500, fontSize: 12),
      bodyLarge: TextStyle(color: AppColors.lightText, fontSize: 16),
      bodyMedium: TextStyle(color: AppColors.lightText, fontSize: 14),
      bodySmall: TextStyle(color: AppColors.lightTextSecondary, fontSize: 12),
      labelLarge: TextStyle(color: AppColors.lightText, fontWeight: FontWeight.w600, fontSize: 14),
      labelMedium: TextStyle(color: AppColors.lightTextSecondary, fontSize: 12),
      labelSmall: TextStyle(color: AppColors.lightTextTertiary, fontSize: 11),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightPrimary,
        foregroundColor: AppColors.white,
        elevation: 2,
        shadowColor: AppColors.grey400,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.grey300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.grey300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.lightPrimary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkPrimary,
      onPrimary: AppColors.black,
      secondary: AppColors.darkSecondary,
      onSecondary: AppColors.black,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkText,
      error: AppColors.error,
      onError: AppColors.white,
      tertiary: AppColors.darkAccent,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      foregroundColor: AppColors.darkText,
      elevation: 0,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: TextStyle(
        color: AppColors.darkText,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    cardTheme: CardThemeData(
      color: AppColors.darkCardBackground,
      elevation: 0,
      shadowColor: AppColors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold, fontSize: 32),
      displayMedium: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold, fontSize: 28),
      displaySmall: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold, fontSize: 24),
      headlineLarge: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold, fontSize: 20),
      headlineMedium: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.w600, fontSize: 18),
      headlineSmall: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.w600, fontSize: 16),
      titleLarge: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.w600, fontSize: 16),
      titleMedium: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.w500, fontSize: 14),
      titleSmall: TextStyle(color: AppColors.darkTextSecondary, fontWeight: FontWeight.w500, fontSize: 12),
      bodyLarge: TextStyle(color: AppColors.darkText, fontSize: 16),
      bodyMedium: TextStyle(color: AppColors.darkText, fontSize: 14),
      bodySmall: TextStyle(color: AppColors.darkTextSecondary, fontSize: 12),
      labelLarge: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.w600, fontSize: 14),
      labelMedium: TextStyle(color: AppColors.darkTextSecondary, fontSize: 12),
      labelSmall: TextStyle(color: AppColors.darkTextTertiary, fontSize: 11),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: AppColors.black,
        elevation: 2,
        shadowColor: AppColors.black,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.grey700),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.grey700),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.darkPrimary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error),
      ),
    ),
  );
}
