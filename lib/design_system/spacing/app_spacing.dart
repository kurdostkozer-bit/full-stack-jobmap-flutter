/// JobMap Spacing System (8dp Base Scale)
/// 
/// Spacing follows an 8dp base scale for consistency:
/// xs = 4dp, sm = 8dp, md = 16dp, lg = 24dp, xl = 32dp, xxl = 48dp
class AppSpacing {
  // Private constructor to prevent instantiation
  AppSpacing._();

  // ============= BASE SCALE (8dp) =============
  /// 4px - Extra small spacing
  static const double xs = 4.0;

  /// 8px - Small spacing
  static const double sm = 8.0;

  /// 16px - Medium spacing (default)
  static const double md = 16.0;

  /// 24px - Large spacing
  static const double lg = 24.0;

  /// 32px - Extra large spacing
  static const double xl = 32.0;

  /// 48px - Double extra large spacing
  static const double xxl = 48.0;

  // ============= INTERMEDIATE SCALES =============
  /// 12px - Between small and medium
  static const double smMd = 12.0;

  /// 20px - Between medium and large
  static const double mdLg = 20.0;

  /// 28px - Between large and extra large
  static const double lgXl = 28.0;

  /// 40px - Between extra large and double extra large
  static const double xlXxl = 40.0;

  // ============= COMPONENT SPECIFIC =============
  /// Default padding for cards
  static const double cardPadding = md;

  /// Default margin between sections
  static const double sectionMargin = lg;

  /// Default padding for buttons
  static const double buttonPaddingHorizontal = md;
  static const double buttonPaddingVertical = sm;

  /// Default padding for input fields
  static const double inputPadding = md;

  /// Default gap in lists
  static const double listGap = sm;

  /// Default corner to corner space
  static const double cornerSpace = xs;

  // ============= COMMON PATTERNS =============
  /// Small spacing pattern (horizontal)
  static const double smallHGap = sm;

  /// Small spacing pattern (vertical)
  static const double smallVGap = sm;

  /// Medium spacing pattern (horizontal)
  static const double mediumHGap = md;

  /// Medium spacing pattern (vertical)
  static const double mediumVGap = md;

  /// Large spacing pattern (horizontal)
  static const double largeHGap = lg;

  /// Large spacing pattern (vertical)
  static const double largeVGap = lg;

  // ============= UTILITY CALCULATIONS =============
  /// Get spacing value multiplier
  static double get(int multiplier) => sm * multiplier;

  /// Half spacing
  static double half(double spacing) => spacing / 2;

  /// Double spacing
  static double double(double spacing) => spacing * 2;

  /// Ratio based spacing
  static double ratio(double base, double ratio) => base * ratio;
}

/// Spacing constants for EdgeInsets
class AppEdgeInsets {
  // Private constructor to prevent instantiation
  AppEdgeInsets._();

  // ============= UNIFORM PADDING =============
  /// EdgeInsets.all(4)
  static const EdgeInsets xs = EdgeInsets.all(AppSpacing.xs);

  /// EdgeInsets.all(8)
  static const EdgeInsets sm = EdgeInsets.all(AppSpacing.sm);

  /// EdgeInsets.all(16)
  static const EdgeInsets md = EdgeInsets.all(AppSpacing.md);

  /// EdgeInsets.all(24)
  static const EdgeInsets lg = EdgeInsets.all(AppSpacing.lg);

  /// EdgeInsets.all(32)
  static const EdgeInsets xl = EdgeInsets.all(AppSpacing.xl);

  /// EdgeInsets.all(48)
  static const EdgeInsets xxl = EdgeInsets.all(AppSpacing.xxl);

  // ============= SYMMETRIC PADDING =============
  /// EdgeInsets.symmetric(horizontal: 8, vertical: 4)
  static const EdgeInsets symmetricSmall = EdgeInsets.symmetric(
    horizontal: AppSpacing.sm,
    vertical: AppSpacing.xs,
  );

  /// EdgeInsets.symmetric(horizontal: 16, vertical: 8)
  static const EdgeInsets symmetricMedium = EdgeInsets.symmetric(
    horizontal: AppSpacing.md,
    vertical: AppSpacing.sm,
  );

  /// EdgeInsets.symmetric(horizontal: 24, vertical: 16)
  static const EdgeInsets symmetricLarge = EdgeInsets.symmetric(
    horizontal: AppSpacing.lg,
    vertical: AppSpacing.md,
  );

  // ============= DIRECTIONAL PADDING =============
  /// EdgeInsets.only(top: 16)
  static const EdgeInsets topMd = EdgeInsets.only(top: AppSpacing.md);

  /// EdgeInsets.only(bottom: 16)
  static const EdgeInsets bottomMd = EdgeInsets.only(bottom: AppSpacing.md);

  /// EdgeInsets.only(left: 16)
  static const EdgeInsets leftMd = EdgeInsets.only(left: AppSpacing.md);

  /// EdgeInsets.only(right: 16)
  static const EdgeInsets rightMd = EdgeInsets.only(right: AppSpacing.md);

  /// EdgeInsets.only(top: 24)
  static const EdgeInsets topLg = EdgeInsets.only(top: AppSpacing.lg);

  /// EdgeInsets.only(bottom: 24)
  static const EdgeInsets bottomLg = EdgeInsets.only(bottom: AppSpacing.lg);

  // ============= SCREEN PADDING =============
  /// Default screen padding
  static const EdgeInsets screenPadding = EdgeInsets.all(AppSpacing.md);

  /// Screen padding with safe area
  static const EdgeInsets screenPaddingLarge = EdgeInsets.all(AppSpacing.lg);

  /// Horizontal screen padding only
  static const EdgeInsets screenHorizontal = EdgeInsets.symmetric(
    horizontal: AppSpacing.md,
  );

  // ============= UTILITY METHODS =============
  /// Create custom symmetric padding
  static EdgeInsets symmetric({
    required double horizontal,
    required double vertical,
  }) =>
      EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);

  /// Create custom directional padding
  static EdgeInsets only({
    double top = 0,
    double bottom = 0,
    double left = 0,
    double right = 0,
  }) =>
      EdgeInsets.only(top: top, bottom: bottom, left: left, right: right);
}

/// SizedBox helpers for spacing
class AppSizedBox {
  // Private constructor to prevent instantiation
  AppSizedBox._();

  // ============= VERTICAL SPACING =============
  static const SizedBox vXs = SizedBox(height: AppSpacing.xs);
  static const SizedBox vSm = SizedBox(height: AppSpacing.sm);
  static const SizedBox vMd = SizedBox(height: AppSpacing.md);
  static const SizedBox vLg = SizedBox(height: AppSpacing.lg);
  static const SizedBox vXl = SizedBox(height: AppSpacing.xl);
  static const SizedBox vXxl = SizedBox(height: AppSpacing.xxl);

  // ============= HORIZONTAL SPACING =============
  static const SizedBox hXs = SizedBox(width: AppSpacing.xs);
  static const SizedBox hSm = SizedBox(width: AppSpacing.sm);
  static const SizedBox hMd = SizedBox(width: AppSpacing.md);
  static const SizedBox hLg = SizedBox(width: AppSpacing.lg);
  static const SizedBox hXl = SizedBox(width: AppSpacing.xl);
  static const SizedBox hXxl = SizedBox(width: AppSpacing.xxl);

  // ============= CUSTOM SPACING =============
  static SizedBox vertical(double height) => SizedBox(height: height);
  static SizedBox horizontal(double width) => SizedBox(width: width);
  static SizedBox square(double size) => SizedBox(width: size, height: size);
}
