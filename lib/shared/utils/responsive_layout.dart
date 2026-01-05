// lib/core/responsive/responsive_layout.dart
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  static const double mobileMaxWidth = 600;
  static const double tabletMaxWidth = 1024;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMaxWidth;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileMaxWidth &&
      MediaQuery.of(context).size.width < tabletMaxWidth;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletMaxWidth;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= tabletMaxWidth) {
      // Desktop
      return desktop ?? tablet ?? mobile;
    } else if (width >= mobileMaxWidth) {
      // Tablet
      return tablet ?? mobile;
    } else {
      // Mobile
      return mobile;
    }
  }
}

// Helper para obtener padding responsive
class ResponsivePadding {
  static EdgeInsets all(BuildContext context) {
    if (ResponsiveLayout.isDesktop(context)) {
      return const EdgeInsets.all(32);
    } else if (ResponsiveLayout.isTablet(context)) {
      return const EdgeInsets.all(24);
    } else {
      return const EdgeInsets.all(16);
    }
  }

  static EdgeInsets horizontal(BuildContext context) {
    if (ResponsiveLayout.isDesktop(context)) {
      return const EdgeInsets.symmetric(horizontal: 48);
    } else if (ResponsiveLayout.isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: 32);
    } else {
      return const EdgeInsets.symmetric(horizontal: 16);
    }
  }
}

// Helper para obtener tamaños responsive
class ResponsiveSize {
  static double fontSize(BuildContext context, double baseFontSize) {
    if (ResponsiveLayout.isDesktop(context)) {
      return baseFontSize * 1.2;
    } else if (ResponsiveLayout.isTablet(context)) {
      return baseFontSize * 1.1;
    } else {
      return baseFontSize;
    }
  }

  static double iconSize(BuildContext context, double baseSize) {
    if (ResponsiveLayout.isDesktop(context)) {
      return baseSize * 1.3;
    } else if (ResponsiveLayout.isTablet(context)) {
      return baseSize * 1.15;
    } else {
      return baseSize;
    }
  }
}
