import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// JobMap Typography System
class AppTypography {
  // Private constructor to prevent instantiation
  AppTypography._();

  // ============= FONT FAMILIES =============
  static const String primaryFont = 'Roboto';
  static const String displayFont = 'Poppins';

  // ============= HEADING STYLES =============
  /// Display Large - 57/64px, 500 weight
  static TextStyle displayLarge = GoogleFonts.poppins(
    fontSize: 57,
    height: 64 / 57,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.5,
  );

  /// Display Medium - 45/52px, 500 weight
  static TextStyle displayMedium = GoogleFonts.poppins(
    fontSize: 45,
    height: 52 / 45,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );

  /// Display Small - 36/44px, 500 weight
  static TextStyle displaySmall = GoogleFonts.poppins(
    fontSize: 36,
    height: 44 / 36,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );

  /// Heading XL - 32/40px, 600 weight
  static TextStyle headingXL = GoogleFonts.poppins(
    fontSize: 32,
    height: 40 / 32,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  /// Heading Large - 28/36px, 600 weight
  static TextStyle headingLarge = GoogleFonts.poppins(
    fontSize: 28,
    height: 36 / 28,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  /// Heading Medium - 24/32px, 600 weight
  static TextStyle headingMedium = GoogleFonts.poppins(
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  /// Heading Small - 20/28px, 600 weight
  static TextStyle headingSmall = GoogleFonts.poppins(
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  // ============= BODY STYLES =============
  /// Body XL - 18/28px, 400 weight
  static TextStyle bodyXL = GoogleFonts.inter(
    fontSize: 18,
    height: 28 / 18,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  /// Body Large - 16/24px, 400 weight
  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  /// Body Medium - 14/20px, 400 weight
  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  /// Body Small - 12/16px, 400 weight
  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  // ============= LABEL STYLES =============
  /// Label Large - 14/20px, 500 weight
  static TextStyle labelLarge = GoogleFonts.inter(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  /// Label Medium - 12/16px, 500 weight
  static TextStyle labelMedium = GoogleFonts.inter(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  /// Label Small - 11/16px, 500 weight
  static TextStyle labelSmall = GoogleFonts.inter(
    fontSize: 11,
    height: 16 / 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  // ============= CAPTION STYLES =============
  /// Caption Large - 12/16px, 400 weight
  static TextStyle captionLarge = GoogleFonts.inter(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );

  /// Caption Medium - 11/16px, 400 weight
  static TextStyle captionMedium = GoogleFonts.inter(
    fontSize: 11,
    height: 16 / 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );

  /// Caption Small - 10/14px, 400 weight
  static TextStyle captionSmall = GoogleFonts.inter(
    fontSize: 10,
    height: 14 / 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );

  // ============= UTILITY STYLES =============
  /// Bold variant
  static TextStyle bold(TextStyle style) {
    return style.copyWith(fontWeight: FontWeight.bold);
  }

  /// Semi-bold variant
  static TextStyle semiBold(TextStyle style) {
    return style.copyWith(fontWeight: FontWeight.w600);
  }

  /// Medium variant
  static TextStyle medium(TextStyle style) {
    return style.copyWith(fontWeight: FontWeight.w500);
  }

  /// Italic variant
  static TextStyle italic(TextStyle style) {
    return style.copyWith(fontStyle: FontStyle.italic);
  }

  /// Apply color
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// Apply letter spacing
  static TextStyle withLetterSpacing(TextStyle style, double letterSpacing) {
    return style.copyWith(letterSpacing: letterSpacing);
  }

  /// Apply line height
  static TextStyle withLineHeight(TextStyle style, double lineHeight) {
    return style.copyWith(height: lineHeight);
  }
}
