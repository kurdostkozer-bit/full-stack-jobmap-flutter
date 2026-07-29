import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../spacing/app_spacing.dart';
import '../../radius/app_radius.dart';

/// Loading shimmer skeleton
class AppSkeletonLoader extends StatelessWidget {
  final int itemCount;
  final double height;
  final double width;
  final EdgeInsets padding;
  final bool isCircular;

  const AppSkeletonLoader({
    super.key,
    this.itemCount = 3,
    this.height = 20,
    this.width = double.infinity,
    this.padding = const EdgeInsets.all(16),
    this.isCircular = false,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      highlightColor: Theme.of(context).colorScheme.surface,
      child: ListView.builder(
        itemCount: itemCount,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          if (isCircular) {
            return Padding(
              padding: padding,
              child: CircleAvatar(
                radius: height / 2,
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
            );
          }
          return Container(
            margin: padding,
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
          );
        },
      ),
    );
  }
}

/// Progress indicator
class AppProgressIndicator extends StatelessWidget {
  final double value;
  final String? label;
  final Color? backgroundColor;
  final Color? valueColor;
  final double height;

  const AppProgressIndicator({
    super.key,
    required this.value,
    this.label,
    this.backgroundColor,
    this.valueColor,
    this.height = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: Theme.of(context).textTheme.labelMedium),
          SizedBox(height: AppSpacing.xs),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(height / 2),
          child: LinearProgressIndicator(
            value: value,
            minHeight: height,
            backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation(
              valueColor ?? Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

/// Circular loading indicator
class AppCircularLoading extends StatelessWidget {
  final double size;
  final Color? color;
  final double strokeWidth;

  const AppCircularLoading({
    super.key,
    this.size = 48,
    this.color,
    this.strokeWidth = 4,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation(
          color ?? Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

/// Loading overlay
class AppLoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? message;

  const AppLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withValues(alpha: 0.3),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppCircularLoading(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  if (message != null) ...[
                    SizedBox(height: AppSpacing.md),
                    Text(
                      message!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }
}
