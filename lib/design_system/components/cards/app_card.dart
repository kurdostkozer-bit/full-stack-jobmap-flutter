import 'package:flutter/material.dart';
import '../../radius/app_radius.dart';

/// Basic card component
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double elevation;
  final BorderRadiusGeometry borderRadius;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.backgroundColor,
    this.elevation = 1,
    BorderRadiusGeometry? borderRadius,
  })  : borderRadius = borderRadius ?? const BorderRadius.all(Radius.circular(12));

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor ?? Theme.of(context).colorScheme.surface,
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: borderRadius as BorderRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius as BorderRadius,
        child: Padding(padding: padding, child: child),
      ),
    );
  }

  /// Elevated card variant
  factory AppCard.elevated({
    Key? key,
    required Widget child,
    EdgeInsets padding = const EdgeInsets.all(16),
    VoidCallback? onTap,
  }) {
    return AppCard(
      key: key,
      padding: padding,
      onTap: onTap,
      elevation: 4,
      child: child,
    );
  }

  /// Outlined card variant
  factory AppCard.outlined({
    Key? key,
    required Widget child,
    EdgeInsets padding = const EdgeInsets.all(16),
    VoidCallback? onTap,
  }) {
    return _OutlinedCard(
      key: key,
      padding: padding,
      onTap: onTap,
      child: child,
    );
  }
}

/// Outlined card with border
class _OutlinedCard extends AppCard {
  const _OutlinedCard({
    super.key,
    required super.child,
    super.padding = const EdgeInsets.all(16),
    super.onTap,
  }) : super(elevation: 0);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
      ),
      color: Theme.of(context).colorScheme.surface,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
