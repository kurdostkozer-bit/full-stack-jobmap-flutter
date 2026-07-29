import 'package:flutter/material.dart';
import 'colors/app_colors.dart';
import 'typography/app_typography.dart';

/// JobMap Theme Configuration - Material Design 3
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // ============= LIGHT THEME =============
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: LightColorScheme.colorScheme,
      scaffoldBackgroundColor: AppColors.lightBackground,
      appBarTheme: _lightAppBarTheme,
      bottomNavigationBarTheme: _lightBottomNavTheme,
      elevatedButtonTheme: _lightElevatedButtonTheme,
      outlinedButtonTheme: _lightOutlinedButtonTheme,
      textButtonTheme: _lightTextButtonTheme,
      inputDecorationTheme: _lightInputDecorationTheme,
      cardTheme: _lightCardTheme,
      iconTheme: const IconThemeData(color: AppColors.lightOnBackground),
      textTheme: AppTypography.lightTextTheme,
    );
  }

  // ============= DARK THEME =============
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: DarkColorScheme.colorScheme,
      scaffoldBackgroundColor: AppColors.darkBackground,
      appBarTheme: _darkAppBarTheme,
      bottomNavigationBarTheme: _darkBottomNavTheme,
      elevatedButtonTheme: _darkElevatedButtonTheme,
      outlinedButtonTheme: _darkOutlinedButtonTheme,
      textButtonTheme: _darkTextButtonTheme,
      inputDecorationTheme: _darkInputDecorationTheme,
      cardTheme: _darkCardTheme,
      iconTheme: const IconThemeData(color: AppColors.darkOnBackground),
      textTheme: AppTypography.darkTextTheme,
    );
  }

  // ============= LIGHT APP BAR THEME =============
  static const AppBarTheme _lightAppBarTheme = AppBarTheme(
    backgroundColor: AppColors.lightSurface,
    foregroundColor: AppColors.lightOnSurface,
    elevation: 0,
    centerTitle: false,
  );

  // ============= DARK APP BAR THEME =============
  static const AppBarTheme _darkAppBarTheme = AppBarTheme(
    backgroundColor: AppColors.darkSurface,
    foregroundColor: AppColors.darkOnSurface,
    elevation: 0,
    centerTitle: false,
  );

  // ============= LIGHT BOTTOM NAV THEME =============
  static const BottomNavigationBarThemeData _lightBottomNavTheme =
      BottomNavigationBarThemeData(
    backgroundColor: AppColors.lightSurface,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.lightOutlineVariant,
  );

  // ============= DARK BOTTOM NAV THEME =============
  static const BottomNavigationBarThemeData _darkBottomNavTheme =
      BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkSurface,
    selectedItemColor: AppColors.primaryLight,
    unselectedItemColor: AppColors.darkOutlineVariant,
  );

  // ============= LIGHT ELEVATED BUTTON THEME =============
  static final ElevatedButtonThemeData _lightElevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );

  // ============= DARK ELEVATED BUTTON THEME =============
  static final ElevatedButtonThemeData _darkElevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryLight,
      foregroundColor: Colors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );

  // ============= LIGHT OUTLINED BUTTON THEME =============
  static final OutlinedButtonThemeData _lightOutlinedButtonTheme =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primary,
      side: const BorderSide(color: AppColors.primary),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );

  // ============= DARK OUTLINED BUTTON THEME =============
  static final OutlinedButtonThemeData _darkOutlinedButtonTheme =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primaryLight,
      side: const BorderSide(color: AppColors.primaryLight),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );

  // ============= LIGHT TEXT BUTTON THEME =============
  static final TextButtonThemeData _lightTextButtonTheme =
      TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
  );

  // ============= DARK TEXT BUTTON THEME =============
  static final TextButtonThemeData _darkTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primaryLight,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
  );

  // ============= LIGHT INPUT THEME =============
  static InputDecorationTheme get _lightInputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightSurfaceVariant,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.lightOutline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.lightOutline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
    );
  }

  // ============= DARK INPUT THEME =============
  static InputDecorationTheme get _darkInputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurfaceVariant,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.darkOutline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.darkOutline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:
            const BorderSide(color: AppColors.primaryLight, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
    );
  }

  // ============= LIGHT CARD THEME =============
  static const CardThemeData _lightCardTheme = CardThemeData(
    color: AppColors.lightSurface,
    elevation: 1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );

  // ============= DARK CARD THEME =============
  static const CardThemeData _darkCardTheme = CardThemeData(
    color: AppColors.darkSurface,
    elevation: 1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );
}
