import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Design system tokens for consistent spacing, sizing, and effects based on Astra AI
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

  // Border Radius System (Astra uses clean 8px, 12px, 16px, 20px curves)
  static const double radiusXs = 6;
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 20;
  static const double radiusFull = 9999;

  // Elevation System
  static List<BoxShadow> elevation1 = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.2),
      blurRadius: 6,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> elevation2 = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.35),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> elevation3 = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.5),
      blurRadius: 28,
      offset: const Offset(0, 8),
    ),
  ];

  // Glow Effects (Astra AI dynamic glows)
  static List<BoxShadow> glowPrimary = [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.35),
      blurRadius: 24,
      spreadRadius: 2,
    ),
  ];

  static List<BoxShadow> glowSecondary = [
    BoxShadow(
      color: AppColors.secondary.withValues(alpha: 0.3),
      blurRadius: 24,
      spreadRadius: 2,
    ),
  ];

  static List<BoxShadow> glowAccent = [
    BoxShadow(
      color: AppColors.accent.withValues(alpha: 0.3),
      blurRadius: 24,
      spreadRadius: 2,
    ),
  ];
}
