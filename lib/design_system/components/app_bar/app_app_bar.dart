import 'package:flutter/material.dart';

/// Custom app bar
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;
  final bool showBackButton;
  final Color? backgroundColor;
  final double elevation;
  final PreferredSizeWidget? bottom;

  const AppAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.onBackPressed,
    this.showBackButton = true,
    this.backgroundColor,
    this.elevation = 0,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleWidget ?? (title != null ? Text(title!) : null),
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.surface,
      elevation: elevation,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            )
          : null,
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (bottom?.preferredSize.height ?? 0),
  );

  /// Search app bar variant
  factory AppAppBar.search({
    Key? key,
    required String hintText,
    required ValueChanged<String> onSearch,
    VoidCallback? onBackPressed,
    List<Widget>? actions,
  }) {
    return _SearchAppBar(
      key: key,
      hintText: hintText,
      onSearch: onSearch,
      onBackPressed: onBackPressed,
      actions: actions,
    );
  }

  /// Simple app bar (no back button)
  factory AppAppBar.simple({
    Key? key,
    String? title,
    Widget? titleWidget,
    List<Widget>? actions,
    Color? backgroundColor,
  }) {
    return AppAppBar(
      key: key,
      title: title,
      titleWidget: titleWidget,
      actions: actions,
      showBackButton: false,
      backgroundColor: backgroundColor,
    );
  }
}

/// Search app bar
class _SearchAppBar extends AppAppBar {
  final String hintText;
  final ValueChanged<String> onSearch;

  const _SearchAppBar({
    super.key,
    required this.hintText,
    required this.onSearch,
    super.onBackPressed,
    super.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      ),
      title: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        onChanged: onSearch,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
