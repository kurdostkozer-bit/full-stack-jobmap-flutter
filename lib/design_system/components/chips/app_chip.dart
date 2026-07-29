import 'package:flutter/material.dart';
import '../../spacing/app_spacing.dart';

/// Custom chip component
class AppChip extends StatefulWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final VoidCallback? onDeleted;
  final Widget? avatar;
  final IconData? icon;

  const AppChip({
    Key? key,
    required this.label,
    this.selected = false,
    this.onSelected,
    this.onDeleted,
    this.avatar,
    this.icon,
  }) : super(key: key);

  @override
  State<AppChip> createState() => _AppChipState();

  /// Filter chip variant
  factory AppChip.filter({
    Key? key,
    required String label,
    bool selected = false,
    ValueChanged<bool>? onSelected,
    Widget? avatar,
  }) {
    return AppChip(
      key: key,
      label: label,
      selected: selected,
      onSelected: onSelected,
      avatar: avatar,
    );
  }

  /// Input chip variant
  factory AppChip.input({
    Key? key,
    required String label,
    VoidCallback? onDeleted,
    Widget? avatar,
  }) {
    return AppChip(
      key: key,
      label: label,
      onDeleted: onDeleted,
      avatar: avatar,
    );
  }

  /// Action chip variant
  factory AppChip.action({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    IconData? icon,
  }) {
    return _ActionChip(
      key: key,
      label: label,
      onPressed: onPressed,
      icon: icon,
    );
  }
}

class _AppChipState extends State<AppChip> {
  late bool _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.label),
      selected: _selected,
      onSelected: (value) {
        setState(() => _selected = value);
        widget.onSelected?.call(value);
      },
      avatar: widget.avatar,
      deleteIcon: widget.onDeleted != null ? const Icon(Icons.close) : null,
      onDeleted: widget.onDeleted,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

/// Action chip
class _ActionChip extends AppChip {
  final VoidCallback? onPressed;

  const _ActionChip({
    Key? key,
    required String label,
    this.onPressed,
    IconData? icon,
  }) : super(
    key: key,
    label: label,
    icon: icon,
  );

  @override
  State<AppChip> createState() => _ActionChipState();
}

class _ActionChipState extends State<_ActionChip> {
  @override
  Widget build(BuildContext context) {
    final actionChip = widget as _ActionChip;
    return ActionChip(
      label: Text(actionChip.label),
      onPressed: actionChip.onPressed,
      avatar: actionChip.icon != null ? Icon(actionChip.icon) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

/// Badge component
class AppBadge extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? child;

  const AppBadge({
    Key? key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
      label: Text(label),
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.error,
      textColor: textColor ?? Colors.white,
      child: child,
    );
  }
}
