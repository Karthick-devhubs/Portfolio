import 'package:flutter/material.dart';

/// Responsive breakpoints and helpers.
class Responsive {
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileBreakpoint &&
      MediaQuery.of(context).size.width < tabletBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletBreakpoint;

  /// Returns value based on screen size.
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    if (isDesktop(context)) return desktop;
    if (isTablet(context)) return tablet ?? desktop;
    return mobile;
  }

  /// Content width constrained for readability.
  static double contentWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= tabletBreakpoint) return 1100;
    if (width >= mobileBreakpoint) return width * 0.9;
    return width * 0.92;
  }

  /// Horizontal padding.
  static EdgeInsets contentPadding(BuildContext context) {
    if (isDesktop(context)) return const EdgeInsets.symmetric(horizontal: 80);
    if (isTablet(context)) return const EdgeInsets.symmetric(horizontal: 40);
    return const EdgeInsets.symmetric(horizontal: 20);
  }
}
