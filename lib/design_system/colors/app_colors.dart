import 'package:flutter/material.dart';

/// JobMap Color System - Light & Dark Theme Support
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // ============= PRIMARY COLORS =============
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4F46E5);

  // ============= SECONDARY COLORS =============
  static const Color secondary = Color(0xFF10B981);
  static const Color secondaryLight = Color(0xFF34D399);
  static const Color secondaryDark = Color(0xFF059669);

  // ============= ACCENT COLORS =============
  static const Color accent = Color(0xFFF59E0B);
  static const Color accentLight = Color(0xFFFBBF24);
  static const Color accentDark = Color(0xFFD97706);

  // ============= STATUS COLORS =============
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // ============= LIGHT THEME COLORS =============
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightOnBackground = Color(0xFF1F2937);
  static const Color lightOnSurface = Color(0xFF1F2937);
  static const Color lightOutline = Color(0xFFE5E7EB);
  static const Color lightOutlineVariant = Color(0xFFD1D5DB);
  static const Color lightSurfaceVariant = Color(0xFFF3F4F6);
  static const Color lightDisabled = Color(0xFFD1D5DB);

  // ============= DARK THEME COLORS =============
  static const Color darkBackground = Color(0xFF111827);
  static const Color darkSurface = Color(0xFF1F2937);
  static const Color darkOnBackground = Color(0xFFF3F4F6);
  static const Color darkOnSurface = Color(0xFFF3F4F6);
  static const Color darkOutline = Color(0xFF374151);
  static const Color darkOutlineVariant = Color(0xFF4B5563);
  static const Color darkSurfaceVariant = Color(0xFF374151);
  static const Color darkDisabled = Color(0xFF4B5563);

  // ============= SEMANTIC COLORS =============
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textHint = Color(0xFFD1D5DB);

  // ============= GRADIENT COLORS =============
  static const List<Color> primaryGradient = [
    Color(0xFF6366F1),
    Color(0xFF8B5CF6),
  ];

  static const List<Color> successGradient = [
    Color(0xFF10B981),
    Color(0xFF14B8A6),
  ];

  // ============= UTILITY COLORS =============
  static const Color transparent = Colors.transparent;
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // ============= NEUTRAL SCALE =============
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);

  // ============= OPACITY HELPERS =============
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }

  static Color blend(Color color1, Color color2, double value) {
    return Color.lerp(color1, color2, value) ?? color1;
  }
}

/// Light Theme Color Scheme
class LightColorScheme {
  static const ColorScheme colorScheme = ColorScheme.light(
    primary: AppColors.primary,
    primaryContainer: AppColors.primaryLight,
    secondary: AppColors.secondary,
    secondaryContainer: AppColors.secondaryLight,
    tertiary: AppColors.accent,
    tertiaryContainer: AppColors.accentLight,
    error: AppColors.error,
    errorContainer: Color(0xFFFEE2E2),
    surface: AppColors.lightSurface,
    onSurface: AppColors.lightOnSurface,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onTertiary: Colors.white,
    onError: Colors.white,
    outline: AppColors.lightOutline,
    outlineVariant: AppColors.lightOutlineVariant,
    surfaceContainerHighest: AppColors.lightSurfaceVariant,
    scrim: Colors.black,
    inverseSurface: AppColors.gray900,
    inversePrimary: AppColors.primaryLight,
  );
}

/// Dark Theme Color Scheme
class DarkColorScheme {
  static const ColorScheme colorScheme = ColorScheme.dark(
    primary: AppColors.primaryLight,
    primaryContainer: AppColors.primary,
    secondary: AppColors.secondaryLight,
    secondaryContainer: AppColors.secondary,
    tertiary: AppColors.accentLight,
    tertiaryContainer: AppColors.accent,
    error: Color(0xFFF87171),
    errorContainer: Color(0xFF7F1D1D),
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkOnSurface,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onTertiary: Colors.white,
    onError: Colors.white,
    outline: AppColors.darkOutline,
    outlineVariant: AppColors.darkOutlineVariant,
    surfaceContainerHighest: AppColors.darkSurfaceVariant,
    scrim: Colors.black,
    inverseSurface: AppColors.gray50,
    inversePrimary: AppColors.primary,
  );
}
