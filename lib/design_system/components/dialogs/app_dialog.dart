import 'package:flutter/material.dart';
import '../../spacing/app_spacing.dart';
import '../buttons/app_button.dart';

/// Alert dialog component
class AppDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? confirmButtonLabel;
  final String? cancelButtonLabel;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isDangerous;

  const AppDialog({
    Key? key,
    required this.title,
    required this.message,
    this.confirmButtonLabel,
    this.cancelButtonLabel,
    this.onConfirm,
    this.onCancel,
    this.isDangerous = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        if (cancelButtonLabel != null)
          TextButton(
            onPressed: onCancel ?? () => Navigator.pop(context),
            child: Text(cancelButtonLabel!),
          ),
        if (confirmButtonLabel != null)
          ElevatedButton(
            onPressed: onConfirm ?? () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: isDangerous
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.primary,
            ),
            child: Text(confirmButtonLabel!),
          ),
      ],
    );
  }

  /// Show dialog
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmButtonLabel,
    String? cancelButtonLabel,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isDangerous = false,
  }) {
    return showDialog(
      context: context,
      builder: (_) => AppDialog(
        title: title,
        message: message,
        confirmButtonLabel: confirmButtonLabel,
        cancelButtonLabel: cancelButtonLabel,
        onConfirm: onConfirm,
        onCancel: onCancel,
        isDangerous: isDangerous,
      ),
    );
  }
}

/// Bottom sheet component
class AppBottomSheet extends StatelessWidget {
  final String? title;
  final Widget child;
  final VoidCallback? onClose;
  final Color? backgroundColor;

  const AppBottomSheet({
    Key? key,
    this.title,
    required this.child,
    this.onClose,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null) ...[
              Padding(
                padding: EdgeInsets.all(AppSpacing.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title!,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      onPressed: onClose ?? () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
            ],
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Show bottom sheet
  static Future<void> show(
    BuildContext context, {
    String? title,
    required Widget child,
    VoidCallback? onClose,
    Color? backgroundColor,
  }) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => AppBottomSheet(
        title: title,
        child: child,
        onClose: onClose,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
