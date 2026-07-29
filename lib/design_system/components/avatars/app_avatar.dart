import 'package:flutter/material.dart';
import '../../spacing/app_spacing.dart';

/// Avatar component with multiple variants
class AppAvatar extends StatelessWidget {
  final String? initials;
  final String? imageUrl;
  final double size;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onTap;
  final bool isOnline;
  final EdgeInsets? padding;

  const AppAvatar({
    Key? key,
    this.initials,
    this.imageUrl,
    this.size = 40,
    this.backgroundColor,
    this.textColor,
    this.onTap,
    this.isOnline = false,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          if (imageUrl != null && imageUrl!.isNotEmpty)
            CircleAvatar(
              radius: size / 2,
              backgroundImage: NetworkImage(imageUrl!),
              backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
            )
          else
            CircleAvatar(
              radius: size / 2,
              backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
              child: Text(
                initials ?? '?',
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: size / 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (isOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: size / 4,
                height: size / 4,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.surface,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Large avatar variant
  factory AppAvatar.large({
    Key? key,
    String? initials,
    String? imageUrl,
    Color? backgroundColor,
    Color? textColor,
    VoidCallback? onTap,
    bool isOnline = false,
  }) {
    return AppAvatar(
      key: key,
      initials: initials,
      imageUrl: imageUrl,
      size: 80,
      backgroundColor: backgroundColor,
      textColor: textColor,
      onTap: onTap,
      isOnline: isOnline,
    );
  }

  /// Small avatar variant
  factory AppAvatar.small({
    Key? key,
    String? initials,
    String? imageUrl,
    Color? backgroundColor,
    Color? textColor,
    VoidCallback? onTap,
    bool isOnline = false,
  }) {
    return AppAvatar(
      key: key,
      initials: initials,
      imageUrl: imageUrl,
      size: 24,
      backgroundColor: backgroundColor,
      textColor: textColor,
      onTap: onTap,
      isOnline: isOnline,
    );
  }
}
