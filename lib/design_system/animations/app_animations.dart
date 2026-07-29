import 'package:flutter/material.dart';

/// JobMap Animation System - Durations and Curves
class AppDuration {
  // Private constructor to prevent instantiation
  AppDuration._();

  // ============= ANIMATION DURATIONS =============
  /// Instant animation (0ms)
  static const Duration instant = Duration.zero;

  /// Fast animation (100ms) - UI interactions, small transitions
  static const Duration fast = Duration(milliseconds: 100);

  /// Normal animation (300ms) - standard transitions
  static const Duration normal = Duration(milliseconds: 300);

  /// Slow animation (500ms) - page transitions, modal animations
  static const Duration slow = Duration(milliseconds: 500);

  /// Very slow animation (800ms) - complex animations
  static const Duration verySlow = Duration(milliseconds: 800);

  // ============= COMPONENT SPECIFIC =============
  /// Button press animation
  static const Duration button = fast;

  /// Card hover animation
  static const Duration cardHover = normal;

  /// Page transition
  static const Duration pageTransition = normal;

  /// Modal animation
  static const Duration modal = normal;

  /// Snackbar animation
  static const Duration snackbar = normal;

  /// Loading animation
  static const Duration loading = slow;

  /// Skeleton loading
  static const Duration skeleton = slow;

  /// Toast animation
  static const Duration toast = normal;
}

/// Animation Curves - Material Design 3 easing functions
class AppCurves {
  // Private constructor to prevent instantiation
  AppCurves._();

  // ============= MATERIAL DESIGN 3 CURVES =============
  /// Standard curve for normal interactions
  /// Used for most animations
  static const Curve standard = Curves.ease;

  /// Accelerated curve for outgoing elements
  /// Elements leave the screen faster
  static const Curve accelerated = Curves.easeIn;

  /// Decelerated curve for incoming elements
  /// Elements enter the screen slower
  static const Curve decelerated = Curves.easeOut;

  /// Emphasized curve - bouncy, energetic
  /// Used for important interactions
  static const Curve emphasized = Curves.easeInOut;

  /// Linear curve - constant speed
  /// Used for continuous animations (loading, progress)
  static const Curve linear = Curves.linear;

  /// Elastic curve - spring-like effect
  static const Curve elastic = Curves.elasticOut;

  /// Bounce curve - bouncy effect
  static const Curve bounce = Curves.bounceOut;

  /// Back curve - slight overshoot
  static const Curve back = Curves.easeInCubic;

  // ============= COMPONENT SPECIFIC CURVES =============
  /// Button press curve
  static const Curve button = Curves.easeIn;

  /// Page transition curve
  static const Curve pageTransition = Curves.easeInOut;

  /// Modal appearance curve
  static const Curve modal = Curves.easeOut;

  /// Loading animation curve
  static const Curve loading = Curves.linear;

  /// Drawer animation curve
  static const Curve drawer = Curves.easeInOut;

  /// FAB animation curve
  static const Curve fab = Curves.easeOut;

  // ============= CUSTOM CURVE FUNCTIONS =============
  /// Cubic bezier curve for smooth animations
  static const Curve cubicBezier = Curves.easeInCubic;

  /// Fast out slow in curve - commonly used in Material Design
  static const Curve fastOutSlowIn = Curves.fastOutSlowIn;

  /// Ease in back curve
  static const Curve easeInBack = Curves.easeInCubic;

  /// Ease out back curve
  static const Curve easeOutBack = Curves.easeOutCubic;

  /// Ease in out back curve
  static const Curve easeInOutBack = Curves.easeInOutCubic;
}

/// Animation helper class for common animation patterns
class AppAnimations {
  // Private constructor to prevent instantiation
  AppAnimations._();

  /// Standard animation with duration and curve
  static AnimationController createController({
    required TickerProvider vsync,
    Duration duration = AppDuration.normal,
    Curve curve = AppCurves.standard,
  }) {
    return AnimationController(
      duration: duration,
      vsync: vsync,
    );
  }

  /// Create opacity animation
  static Animation<double> opacity({
    required AnimationController controller,
    Curve curve = AppCurves.standard,
  }) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: curve),
    );
  }

  /// Create slide animation
  static Animation<Offset> slide({
    required AnimationController controller,
    required Offset begin,
    required Offset end,
    Curve curve = AppCurves.standard,
  }) {
    return Tween<Offset>(begin: begin, end: end).animate(
      CurvedAnimation(parent: controller, curve: curve),
    );
  }

  /// Create scale animation
  static Animation<double> scale({
    required AnimationController controller,
    double begin = 0.0,
    double end = 1.0,
    Curve curve = AppCurves.standard,
  }) {
    return Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(parent: controller, curve: curve),
    );
  }

  /// Create rotation animation
  static Animation<double> rotation({
    required AnimationController controller,
    double begin = 0.0,
    double end = 1.0,
    Curve curve = AppCurves.linear,
  }) {
    return Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(parent: controller, curve: curve),
    );
  }

  /// Create color animation
  static Animation<Color?> color({
    required AnimationController controller,
    required Color begin,
    required Color end,
    Curve curve = AppCurves.standard,
  }) {
    return ColorTween(begin: begin, end: end).animate(
      CurvedAnimation(parent: controller, curve: curve),
    );
  }
}

/// Transition Tween values
class AppTransitionValues {
  // Private constructor to prevent instantiation
  AppTransitionValues._();

  /// Default opacity range
  static final Tween<double> opacity = Tween<double>(begin: 0.0, end: 1.0);

  /// Default scale range
  static final Tween<double> scale = Tween<double>(begin: 0.8, end: 1.0);

  /// Default rotation range
  static final Tween<double> rotation = Tween<double>(begin: 0.0, end: 1.0);

  /// Slide from left
  static final Tween<Offset> slideFromLeft =
      Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero);

  /// Slide from right
  static final Tween<Offset> slideFromRight =
      Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero);

  /// Slide from top
  static final Tween<Offset> slideFromTop =
      Tween<Offset>(begin: const Offset(0.0, -1.0), end: Offset.zero);

  /// Slide from bottom
  static final Tween<Offset> slideFromBottom =
      Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero);
}
