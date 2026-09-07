import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Design system tokens for consistent spacing, sizing, animations, and elevation.
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
  static const double space12 = 80;
  static const double space16 = 100;

  // Border Radius System
  static const double radiusXs = 6;
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 20;
  static const double radius2Xl = 28;
  static const double radiusFull = 9999;

  // Animation Curves & Durations
  static const Duration durationFast = Duration(milliseconds: 180);
  static const Duration durationMedium = Duration(milliseconds: 320);
  static const Duration durationSlow = Duration(milliseconds: 600);
  static const Duration durationSuperSlow = Duration(milliseconds: 1000);

  static const Curve curveDefault = Curves.easeOutCubic;
  static const Curve curveSpring = Curves.elasticOut;
  static const Curve curveSmooth = Curves.easeInOutCubicEmphasized;

  // Elevation & Box Shadow System
  static List<BoxShadow> elevation1 = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.25),
      blurRadius: 10,
      offset: const Offset(0, 3),
    ),
  ];

  static List<BoxShadow> elevation2 = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.4),
      blurRadius: 20,
      offset: const Offset(0, 6),
    ),
  ];

  static List<BoxShadow> elevation3 = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.55),
      blurRadius: 36,
      offset: const Offset(0, 10),
    ),
  ];

  // Neon Dynamic Glows
  static List<BoxShadow> glowPrimary = [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.4),
      blurRadius: 28,
      spreadRadius: 2,
    ),
  ];

  static List<BoxShadow> glowSecondary = [
    BoxShadow(
      color: AppColors.secondary.withValues(alpha: 0.35),
      blurRadius: 28,
      spreadRadius: 2,
    ),
  ];

  static List<BoxShadow> glowCyan = [
    BoxShadow(
      color: AppColors.accentCyan.withValues(alpha: 0.35),
      blurRadius: 26,
      spreadRadius: 2,
    ),
  ];

  static List<BoxShadow> glowAccent = [
    BoxShadow(
      color: AppColors.accent.withValues(alpha: 0.35),
      blurRadius: 26,
      spreadRadius: 2,
    ),
  ];
}
