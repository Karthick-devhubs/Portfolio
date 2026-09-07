import 'package:flutter/material.dart';

/// Centralized color palette for the portfolio app, matching the Astra AI (astra-ai.co) design system.
class AppColors {
  // Primary Astra AI brand colors
  static const Color primary = Color(0xFF3C50E0); // Astra Electric Blue
  static const Color primaryLight = Color(0xFF5B6DF5);
  static const Color primaryDark = Color(0xFF22319C);

  static const Color secondary = Color(0xFFB478FF); // Astra Radiant Violet / Purple
  static const Color secondaryLight = Color(0xFFCDA4FF);

  static const Color accent = Color(0xFFF1AC0C); // Astra Golden Amber
  static const Color accentLight = Color(0xFFFFC642);

  // Backgrounds & Surfaces (Astra Dark Theme)
  static const Color background = Color(0xFF0C0C0D); // Deep Obsidian
  static const Color cardDark = Color(0xFF141415); // Signature Astra Card Surface
  static const Color surface = Color(0xFF191A1E); // Medium Contrast Surface
  static const Color surfaceElevated = Color(0xFF212227);
  static const Color surfaceBorder = Color(0xFF2B2C30);
  static const Color borderSubtle = Color(0x1FFFFFFF); // 12% White Translucent Border

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFD9D9D9);
  static const Color textMuted = Color(0xFF7B7E8C);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3C50E0);

  // Glow & Atmosphere
  static const Color glowPrimary = Color(0x593C50E0); // ~35% Opacity
  static const Color glowSecondary = Color(0x4DB478FF); // ~30% Opacity
  static const Color glowAccent = Color(0x4DF1AC0C);

  // Light theme fallbacks
  static const Color lightBackground = Color(0xFFF7F8FA);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF0C0C0D);
  static const Color lightTextSecondary = Color(0xFF4B4F5E);

  // Signature Astra Gradients
  /// Flagship 3-color Astra Harmonious Gradient (Blue -> Violet -> Amber)
  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF3C50E0), Color(0xFFB478FF), Color(0xFFF1AC0C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Primary Action Gradient (Electric Blue -> Purple)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF3C50E0), Color(0xFF7F66F0), Color(0xFFB478FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Attention Gradient (Violet -> Amber)
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFB478FF), Color(0xFFF1AC0C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Card Surface Gradient
  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF191A1E), Color(0xFF141415)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Blue Button Gradient
  static const LinearGradient buttonBlueGradient = LinearGradient(
    colors: [Color(0xFF3C50E0), Color(0xFF22319C)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
