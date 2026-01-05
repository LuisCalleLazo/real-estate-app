import 'package:flutter/cupertino.dart';

class NavigationItemData {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  NavigationItemData({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
