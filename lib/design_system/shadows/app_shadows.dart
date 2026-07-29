import 'package:flutter/material.dart';

/// JobMap Shadow System - Elevation-based shadows
class AppShadows {
  // Private constructor to prevent instantiation
  AppShadows._();

  // ============= SHADOW DEFINITIONS =============
  /// No shadow
  static const List<BoxShadow> none = [];

  /// Low elevation shadow (used for small cards, inputs)
  static const List<BoxShadow> low = [
    BoxShadow(
      color: Color(0x0F000000),
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x14000000),
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 1,
    ),
  ];

  /// Medium elevation shadow (used for cards, buttons)
  static const List<BoxShadow> medium = [
    BoxShadow(
      color: Color(0x0F000000),
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -2,
    ),
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -2,
    ),
  ];

  /// High elevation shadow (used for dialogs, modals)
  static const List<BoxShadow> high = [
    BoxShadow(
      color: Color(0x0F000000),
      offset: Offset(0, 20),
      blurRadius: 25,
      spreadRadius: -5,
    ),
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 8),
      blurRadius: 10,
      spreadRadius: -6,
    ),
  ];

  /// Extra high elevation shadow (used for floating elements)
  static const List<BoxShadow> extraHigh = [
    BoxShadow(
      color: Color(0x14000000),
      offset: Offset(0, 25),
      blurRadius: 50,
      spreadRadius: -12,
    ),
  ];

  // ============= COMPONENT SPECIFIC =============
  /// Button shadow (subtle)
  static const List<BoxShadow> button = low;

  /// Card shadow (standard)
  static const List<BoxShadow> card = medium;

  /// Input shadow (subtle)
  static const List<BoxShadow> input = low;

  /// Dialog shadow (prominent)
  static const List<BoxShadow> dialog = high;

  /// Floating Action Button shadow
  static const List<BoxShadow> fab = high;

  /// Bottom Sheet shadow
  static const List<BoxShadow> bottomSheet = high;

  // ============= CUSTOM SHADOW HELPER =============
  /// Create custom shadow
  static List<BoxShadow> custom({
    required Color color,
    required Offset offset,
    required double blurRadius,
    double spreadRadius = 0,
  }) =>
      [
        BoxShadow(
          color: color,
          offset: offset,
          blurRadius: blurRadius,
          spreadRadius: spreadRadius,
        ),
      ];

  /// Create elevation shadow (based on Material Design 3)
  static List<BoxShadow> elevation(int level) {
    switch (level) {
      case 0:
        return none;
      case 1:
        return low;
      case 2:
        return medium;
      case 3:
      case 4:
        return high;
      case 5:
        return extraHigh;
      default:
        return none;
    }
  }
}

/// Elevation constants for convenience
class AppElevation {
  // Private constructor to prevent instantiation
  AppElevation._();

  /// No elevation
  static const double none = 0;

  /// Low elevation (small cards, inputs)
  static const double low = 1;

  /// Medium elevation (cards, buttons)
  static const double medium = 2;

  /// High elevation (dialogs, modals)
  static const double high = 4;

  /// Extra high elevation (floating elements)
  static const double extraHigh = 5;

  /// Button elevation
  static const double button = 1;

  /// Card elevation
  static const double card = 2;

  /// Dialog elevation
  static const double dialog = 4;

  /// FAB elevation
  static const double fab = 6;

  /// FAB pressed elevation
  static const double fabPressed = 12;
}
