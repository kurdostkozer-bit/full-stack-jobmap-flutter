import 'package:flutter/material.dart';

/// Bottom navigation bar component
class AppBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final List<BottomNavigationBarItem> items;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;

  const AppBottomNav({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.items,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemSelected,
      items: items,
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.surface,
      selectedItemColor: selectedItemColor ?? Theme.of(context).colorScheme.primary,
      unselectedItemColor: unselectedItemColor ?? Theme.of(context).colorScheme.outline,
      type: BottomNavigationBarType.fixed,
    );
  }
}
