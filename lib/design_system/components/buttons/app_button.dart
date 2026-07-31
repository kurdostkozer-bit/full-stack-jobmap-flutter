import 'package:flutter/material.dart';
import '../../spacing/app_spacing.dart';
import '../../radius/app_radius.dart';

/// Elevated Button with primary styling
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final EdgeInsets? padding;
  final Icon? prefixIcon;
  final Icon? suffixIcon;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.padding,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final buttonPadding = padding ?? EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.sm,
    );

    final child = isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(
                Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (prefixIcon != null) ...[
                prefixIcon!,
                SizedBox(width: AppSpacing.sm),
              ],
              Text(label),
              if (suffixIcon != null) ...[
                SizedBox(width: AppSpacing.sm),
                suffixIcon!,
              ],
            ],
          );

    final button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: buttonPadding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        elevation: 0,
      ),
      child: child,
    );

    return isFullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }

  /// Secondary variant
  factory AppButton.secondary({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isFullWidth = true,
    Icon? prefixIcon,
    Icon? suffixIcon,
  }) {
    return _SecondaryButton(
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      key: key,
    );
  }

  /// Tertiary variant
  factory AppButton.tertiary({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isFullWidth = true,
    Icon? prefixIcon,
    Icon? suffixIcon,
  }) {
    return _TertiaryButton(
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      key: key,
    );
  }

  /// Outline variant
  factory AppButton.outline({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isFullWidth = true,
    Icon? prefixIcon,
    Icon? suffixIcon,
  }) {
    return _OutlineButton(
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      key: key,
    );
  }

  /// Icon button variant
  factory AppButton.icon({
    Key? key,
    required IconData icon,
    VoidCallback? onPressed,
    bool isLoading = false,
    Color? backgroundColor,
    Color? foregroundColor,
    double size = 24,
  }) {
    return _IconButton(
      icon: icon,
      onPressed: onPressed,
      isLoading: isLoading,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      size: size,
      key: key,
    );
  }

  /// Glass Green variant (green glassmorphism style)
  factory AppButton.glassGreen({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isFullWidth = true,
    Icon? prefixIcon,
    Icon? suffixIcon,
  }) {
    return _GlassGreenButton(
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      key: key,
    );
  }
}

/// Secondary button (filled with secondary color)
class _SecondaryButton extends AppButton {
  const _SecondaryButton({
    super.key,
    required super.label,
    super.onPressed,
    super.isLoading = false,
    super.isFullWidth = true,
    super.prefixIcon,
    super.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(
                Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (prefixIcon != null) ...[
                prefixIcon!,
                SizedBox(width: AppSpacing.sm),
              ],
              Text(label),
              if (suffixIcon != null) ...[
                SizedBox(width: AppSpacing.sm),
                suffixIcon!,
              ],
            ],
          );

    final button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        elevation: 0,
      ),
      child: child,
    );

    return isFullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }
}

/// Tertiary button (text only)
class _TertiaryButton extends AppButton {
  const _TertiaryButton({
    super.key,
    required super.label,
    super.onPressed,
    super.isLoading = false,
    super.isFullWidth = true,
    super.prefixIcon,
    super.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(
                Theme.of(context).colorScheme.primary,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (prefixIcon != null) ...[
                prefixIcon!,
                SizedBox(width: AppSpacing.sm),
              ],
              Text(label),
              if (suffixIcon != null) ...[
                SizedBox(width: AppSpacing.sm),
                suffixIcon!,
              ],
            ],
          );

    final button = TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),
      child: child,
    );

    return isFullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }
}

/// Outline button (border only)
class _OutlineButton extends AppButton {
  const _OutlineButton({
    super.key,
    required super.label,
    super.onPressed,
    super.isLoading = false,
    super.isFullWidth = true,
    super.prefixIcon,
    super.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(
                Theme.of(context).colorScheme.primary,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (prefixIcon != null) ...[
                prefixIcon!,
                SizedBox(width: AppSpacing.sm),
              ],
              Text(label),
              if (suffixIcon != null) ...[
                SizedBox(width: AppSpacing.sm),
                suffixIcon!,
              ],
            ],
          );

    final button = OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.primary,
        side: BorderSide(color: Theme.of(context).colorScheme.primary),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
      child: child,
    );

    return isFullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }
}

/// Icon button
class _IconButton extends AppButton {
  final IconData icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double size;

  const _IconButton({
    super.key,
    required this.icon,
    super.onPressed,
    super.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.size = 24,
  }) : super(label: '');

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isLoading ? null : onPressed,
      icon: isLoading
          ? SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(
                  foregroundColor ?? Theme.of(context).colorScheme.primary,
                ),
              ),
            )
          : Icon(
              icon,
              size: size,
              color: foregroundColor,
            ),
      style: IconButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.all(AppSpacing.sm),
      ),
    );
  }
}

/// Glass Green button (green glassmorphism style)
class _GlassGreenButton extends AppButton {
  const _GlassGreenButton({
    super.key,
    required super.label,
    super.onPressed,
    super.isLoading = false,
    super.isFullWidth = true,
    super.prefixIcon,
    super.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: const AlwaysStoppedAnimation(
                Colors.white,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (prefixIcon != null) ...[
                prefixIcon!,
                SizedBox(width: AppSpacing.sm),
              ],
              Text(label),
              if (suffixIcon != null) ...[
                SizedBox(width: AppSpacing.sm),
                suffixIcon!,
              ],
            ],
          );

    final button = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.md),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF10B981).withValues(alpha: 0.9), // Glass Green
            const Color(0xFF059669).withValues(alpha: 0.85), // Dark Green
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withValues(alpha: 0.4),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: const Color(0xFF10B981).withValues(alpha: 0.2),
            blurRadius: 25,
            spreadRadius: 5,
          ),
        ],
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Center(child: child),
          ),
        ),
      ),
    );

    return isFullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }
}

