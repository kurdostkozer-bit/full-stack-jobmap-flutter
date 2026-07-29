import 'package:flutter/material.dart';

/// BuildContext extensions for convenient access to Theme, MediaQuery, etc.
extension BuildContextExtensions on BuildContext {
  // ============= THEME SHORTCUTS =============
  /// Get current theme data
  ThemeData get theme => Theme.of(this);

  /// Get current color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Get current text theme
  TextTheme get textTheme => theme.textTheme;

  /// Get current brightness (light/dark)
  Brightness get brightness => theme.brightness;

  /// Is dark mode?
  bool get isDarkMode => brightness == Brightness.dark;

  /// Is light mode?
  bool get isLightMode => brightness == Brightness.light;

  // ============= COLOR SHORTCUTS =============
  /// Primary color
  Color get primary => colorScheme.primary;

  /// Secondary color
  Color get secondary => colorScheme.secondary;

  /// Tertiary color
  Color get tertiary => colorScheme.tertiary;

  /// Error color
  Color get error => colorScheme.error;

  /// Background color
  Color get background => colorScheme.surface;

  /// Surface color
  Color get surface => colorScheme.surface;

  /// OnBackground color
  Color get onBackground => colorScheme.onSurface;

  /// OnSurface color
  Color get onSurface => colorScheme.onSurface;

  /// Outline color
  Color get outline => colorScheme.outline;

  // ============= MEDIA QUERY SHORTCUTS =============
  /// Get media query data
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Screen size
  Size get screenSize => mediaQuery.size;

  /// Screen width
  double get screenWidth => screenSize.width;

  /// Screen height
  double get screenHeight => screenSize.height;

  /// Device padding (safe area)
  EdgeInsets get padding => mediaQuery.padding;

  /// Device view insets (keyboard, notch)
  EdgeInsets get viewInsets => mediaQuery.viewInsets;

  /// Top padding (notch/status bar)
  double get topPadding => padding.top;

  /// Bottom padding (home indicator)
  double get bottomPadding => padding.bottom;

  /// Keyboard height
  double get keyboardHeight => viewInsets.bottom;

  /// Is keyboard open?
  bool get isKeyboardOpen => keyboardHeight > 0;

  /// Is landscape?
  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;

  /// Is portrait?
  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;

  /// Device aspect ratio
  double get aspectRatio => screenSize.aspectRatio;

  /// Device pixel ratio
  double get devicePixelRatio => mediaQuery.devicePixelRatio;

  // ============= RESPONSIVE SHORTCUTS =============
  /// Is mobile (width < 600)
  bool get isMobile => screenWidth < 600;

  /// Is tablet (width >= 600)
  bool get isTablet => screenWidth >= 600;

  /// Is large screen (width >= 1200)
  bool get isLargeScreen => screenWidth >= 1200;

  /// Get responsive breakpoint
  String get breakpoint {
    if (screenWidth < 600) return 'mobile';
    if (screenWidth < 900) return 'tablet';
    if (screenWidth < 1200) return 'desktop';
    return 'largeDesktop';
  }

  /// Get responsive value based on screen width
  T responsive<T>({
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    if (screenWidth < 600) return mobile;
    if (screenWidth < 900) return tablet ?? mobile;
    if (screenWidth < 1200) return desktop ?? tablet ?? mobile;
    return largeDesktop ?? desktop ?? tablet ?? mobile;
  }

  // ============= NAVIGATION SHORTCUTS =============
  /// Pop route
  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }

  /// Can pop?
  bool get canPop => Navigator.of(this).canPop();

  // ============= DIALOG SHORTCUTS =============
  /// Show snackbar
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 2),
    SnackBarAction? action,
  }) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
      ),
    );
  }

  /// Show error snackbar
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showError(
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: colorScheme.error,
        duration: duration,
      ),
    );
  }

  /// Show success snackbar
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSuccess(
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: duration,
      ),
    );
  }

  /// Focus next field
  void focusNext() {
    FocusScope.of(this).nextFocus();
  }

  /// Unfocus current field
  void unfocus() {
    FocusScope.of(this).unfocus();
  }
}
