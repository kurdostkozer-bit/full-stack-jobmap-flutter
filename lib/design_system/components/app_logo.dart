import 'package:flutter/material.dart';

/// JobMap Logo Widget - Reusable logo component
class AppLogo extends StatelessWidget {
  /// Size of the logo (width and height)
  final double size;

  /// Optional custom width
  final double? width;

  /// Optional custom height
  final double? height;

  /// Fit property for the image
  final BoxFit fit;

  /// Optional onTap callback
  final VoidCallback? onTap;

  const AppLogo({
    super.key,
    this.size = 48,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final logoWidth = width ?? size;
    final logoHeight = height ?? size;

    Widget logo = Image.asset(
      'assets/images/logo.png',
      width: logoWidth,
      height: logoHeight,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        // Fallback if logo is not found
        return Container(
          width: logoWidth,
          height: logoHeight,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              'JM',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        );
      },
    );

    if (onTap != null) {
      logo = GestureDetector(
        onTap: onTap,
        child: logo,
      );
    }

    return logo;
  }
}

/// Logo sizes preset
class LogoSizes {
  static const double xs = 24;
  static const double sm = 32;
  static const double md = 48;
  static const double lg = 64;
  static const double xl = 96;
  static const double xxl = 128;
}
