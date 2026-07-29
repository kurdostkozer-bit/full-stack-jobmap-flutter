import 'package:flutter/material.dart';

/// JobMap Border Radius System
class AppRadius {
  // Private constructor to prevent instantiation
  AppRadius._();

  // ============= BORDER RADIUS SCALE =============
  /// No rounding
  static const double none = 0.0;

  /// 4px - Extra small rounding
  static const double xs = 4.0;

  /// 8px - Small rounding
  static const double sm = 8.0;

  /// 12px - Medium rounding
  static const double md = 12.0;

  /// 16px - Large rounding
  static const double lg = 16.0;

  /// 24px - Extra large rounding
  static const double xl = 24.0;

  /// 32px - Double extra large rounding
  static const double xxl = 32.0;

  /// 50% - Full circle/pill shape
  static const double full = 50.0;

  // ============= COMPONENT SPECIFIC =============
  /// Button border radius
  static const double button = md;

  /// Input field border radius
  static const double input = md;

  /// Card border radius
  static const double card = lg;

  /// Avatar border radius
  static const double avatar = full;

  /// Dialog border radius
  static const double dialog = xl;

  /// Bottom sheet border radius (top only)
  static const double bottomSheet = xl;

  /// Chip border radius
  static const double chip = sm;
}

/// BorderRadius constants
class AppBorderRadius {
  // Private constructor to prevent instantiation
  AppBorderRadius._();

  // ============= ALL CORNERS =============
  /// BorderRadius.circular(0)
  static const BorderRadius none = BorderRadius.zero;

  /// BorderRadius.circular(4)
  static const BorderRadius xs = BorderRadius.all(Radius.circular(AppRadius.xs));

  /// BorderRadius.circular(8)
  static const BorderRadius sm = BorderRadius.all(Radius.circular(AppRadius.sm));

  /// BorderRadius.circular(12)
  static const BorderRadius md = BorderRadius.all(Radius.circular(AppRadius.md));

  /// BorderRadius.circular(16)
  static const BorderRadius lg = BorderRadius.all(Radius.circular(AppRadius.lg));

  /// BorderRadius.circular(24)
  static const BorderRadius xl = BorderRadius.all(Radius.circular(AppRadius.xl));

  /// BorderRadius.circular(32)
  static const BorderRadius xxl = BorderRadius.all(Radius.circular(AppRadius.xxl));

  /// BorderRadius.circular(50) - Full circle
  static const BorderRadius full = BorderRadius.all(Radius.circular(AppRadius.full));

  // ============= TOP ONLY =============
  /// BorderRadius.only(topLeft: 16, topRight: 16)
  static const BorderRadius topMd = BorderRadius.only(
    topLeft: Radius.circular(AppRadius.md),
    topRight: Radius.circular(AppRadius.md),
  );

  /// BorderRadius.only(topLeft: 24, topRight: 24)
  static const BorderRadius topLg = BorderRadius.only(
    topLeft: Radius.circular(AppRadius.lg),
    topRight: Radius.circular(AppRadius.lg),
  );

  /// BorderRadius.only(topLeft: 32, topRight: 32)
  static const BorderRadius topXl = BorderRadius.only(
    topLeft: Radius.circular(AppRadius.xl),
    topRight: Radius.circular(AppRadius.xl),
  );

  // ============= BOTTOM ONLY =============
  /// BorderRadius.only(bottomLeft: 16, bottomRight: 16)
  static const BorderRadius bottomMd = BorderRadius.only(
    bottomLeft: Radius.circular(AppRadius.md),
    bottomRight: Radius.circular(AppRadius.md),
  );

  /// BorderRadius.only(bottomLeft: 24, bottomRight: 24)
  static const BorderRadius bottomLg = BorderRadius.only(
    bottomLeft: Radius.circular(AppRadius.lg),
    bottomRight: Radius.circular(AppRadius.lg),
  );

  /// BorderRadius.only(bottomLeft: 32, bottomRight: 32)
  static const BorderRadius bottomXl = BorderRadius.only(
    bottomLeft: Radius.circular(AppRadius.xl),
    bottomRight: Radius.circular(AppRadius.xl),
  );

  // ============= LEFT ONLY =============
  /// BorderRadius.only(topLeft: 16, bottomLeft: 16)
  static const BorderRadius leftMd = BorderRadius.only(
    topLeft: Radius.circular(AppRadius.md),
    bottomLeft: Radius.circular(AppRadius.md),
  );

  /// BorderRadius.only(topLeft: 24, bottomLeft: 24)
  static const BorderRadius leftLg = BorderRadius.only(
    topLeft: Radius.circular(AppRadius.lg),
    bottomLeft: Radius.circular(AppRadius.lg),
  );

  // ============= RIGHT ONLY =============
  /// BorderRadius.only(topRight: 16, bottomRight: 16)
  static const BorderRadius rightMd = BorderRadius.only(
    topRight: Radius.circular(AppRadius.md),
    bottomRight: Radius.circular(AppRadius.md),
  );

  /// BorderRadius.only(topRight: 24, bottomRight: 24)
  static const BorderRadius rightLg = BorderRadius.only(
    topRight: Radius.circular(AppRadius.lg),
    bottomRight: Radius.circular(AppRadius.lg),
  );

  // ============= UTILITY METHODS =============
  /// Create custom border radius for all corners
  static BorderRadius all(double radius) =>
      BorderRadius.all(Radius.circular(radius));

  /// Create custom border radius for top corners only
  static BorderRadius only({
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
  }) =>
      BorderRadius.only(
        topLeft: Radius.circular(topLeft),
        topRight: Radius.circular(topRight),
        bottomLeft: Radius.circular(bottomLeft),
        bottomRight: Radius.circular(bottomRight),
      );

  /// Create custom border radius for horizontal corners
  static BorderRadius top(double radius) => BorderRadius.only(
    topLeft: Radius.circular(radius),
    topRight: Radius.circular(radius),
  );

  /// Create custom border radius for bottom corners
  static BorderRadius bottom(double radius) => BorderRadius.only(
    bottomLeft: Radius.circular(radius),
    bottomRight: Radius.circular(radius),
  );

  /// Create custom border radius for left corners
  static BorderRadius left(double radius) => BorderRadius.only(
    topLeft: Radius.circular(radius),
    bottomLeft: Radius.circular(radius),
  );

  /// Create custom border radius for right corners
  static BorderRadius right(double radius) => BorderRadius.only(
    topRight: Radius.circular(radius),
    bottomRight: Radius.circular(radius),
  );
}

/// RoundedRectangleBorder constants for convenience
class AppRoundedRectangleBorder {
  // Private constructor to prevent instantiation
  AppRoundedRectangleBorder._();

  static const RoundedRectangleBorder xs =
      RoundedRectangleBorder(borderRadius: AppBorderRadius.xs);

  static const RoundedRectangleBorder sm =
      RoundedRectangleBorder(borderRadius: AppBorderRadius.sm);

  static const RoundedRectangleBorder md =
      RoundedRectangleBorder(borderRadius: AppBorderRadius.md);

  static const RoundedRectangleBorder lg =
      RoundedRectangleBorder(borderRadius: AppBorderRadius.lg);

  static const RoundedRectangleBorder xl =
      RoundedRectangleBorder(borderRadius: AppBorderRadius.xl);

  static const RoundedRectangleBorder xxl =
      RoundedRectangleBorder(borderRadius: AppBorderRadius.xxl);

  static const RoundedRectangleBorder full =
      RoundedRectangleBorder(borderRadius: AppBorderRadius.full);
}
