import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Design system tokens for consistent spacing, sizing, and effects
class AppDesignTokens {
  // Spacing System (8px base)
  static const double space1 = 4;
  static const double space2 = 8;
  static const double space3 = 12;
  static const double space4 = 16;
  static const double space5 = 24;
  static const double space6 = 32;
  static const double space8 = 48;
  static const double space10 = 64;

  // Border Radius System
  static const double radiusXs = 4;
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;
  static const double radiusFull = 9999;

  // Elevation System
  static List<BoxShadow> elevation1 = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> elevation2 = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> elevation3 = [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];

  // Glow Effects
  static List<BoxShadow> glowPrimary = [
    BoxShadow(
      color: AppColors.primary.withOpacity(0.3),
      blurRadius: 24,
      spreadRadius: 2,
    ),
  ];

  static List<BoxShadow> glowSecondary = [
    BoxShadow(
      color: AppColors.secondary.withOpacity(0.3),
      blurRadius: 24,
      spreadRadius: 2,
    ),
  ];
}
