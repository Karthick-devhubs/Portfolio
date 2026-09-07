import 'package:flutter/material.dart';

/// Centralized color palette for the portfolio app, featuring an ultra-sleek,
/// high-contrast cyber dark theme with radiant glowing gradients and neon accents.
class AppColors {
  // Brand Core Colors
  static const Color primary = Color(0xFF3C50E0); // Electric Astra Blue
  static const Color primaryLight = Color(0xFF5B6DF5);
  static const Color primaryDark = Color(0xFF1E2B8F);

  static const Color secondary = Color(0xFFB478FF); // Radiant Neon Violet
  static const Color secondaryLight = Color(0xFFCF9EFF);
  static const Color secondaryDark = Color(0xFF7E3BE0);

  static const Color accent = Color(0xFFF1AC0C); // Warm Golden Amber
  static const Color accentLight = Color(0xFFFFCE52);
  static const Color accentCyan = Color(0xFF00F5D4); // Cyber Neon Cyan

  // Deep Obsidian Backgrounds & Glass Surfaces
  static const Color background = Color(0xFF090A0F); // Deep Cosmic Obsidian
  static const Color backgroundSecondary = Color(0xFF0E1017);
  static const Color cardDark = Color(0xFF141415); // Card Surface
  static const Color cardElevated = Color(0xFF1A1D2B);
  static const Color surface = Color(0xFF161824);
  static const Color surfaceElevated = Color(0xFF202334);
  static const Color surfaceBorder = Color(0xFF262A3E);
  static const Color borderSubtle = Color(0x1FFFFFFF); // 12% White Translucent
  static const Color borderGlow = Color(0x403C50E0);

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFD4D8E6);
  static const Color textMuted = Color(0xFF888E9F);
  static const Color textTertiary = Color(0xFF5E6476);

  // Status & Feedback Colors
  static const Color success = Color(0xFF10B981);
  static const Color successGlow = Color(0x4D10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3C50E0);

  // Dynamic Glow Atmosphere
  static const Color glowPrimary = Color(0x593C50E0);
  static const Color glowSecondary = Color(0x4DB478FF);
  static const Color glowAccent = Color(0x4DF1AC0C);
  static const Color glowCyan = Color(0x4D00F5D4);

  // Light theme fallbacks
  static const Color lightBackground = Color(0xFFF6F8FC);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF0B0D17);
  static const Color lightTextSecondary = Color(0xFF474F64);

  // Gradients
  /// Flagship 3-color Harmonious Gradient (Blue -> Violet -> Amber)
  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF3C50E0), Color(0xFFB478FF), Color(0xFFF1AC0C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Primary Action Gradient (Electric Blue -> Radiant Violet)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF3C50E0), Color(0xFF7E5BE8), Color(0xFFB478FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Cyber Neon Gradient (Cyan -> Blue -> Violet)
  static const LinearGradient cyberGradient = LinearGradient(
    colors: [Color(0xFF00F5D4), Color(0xFF3C50E0), Color(0xFFB478FF)],
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
    colors: [Color(0xFF181B28), Color(0xFF11131C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Glowing Border Gradient
  static const LinearGradient borderGradient = LinearGradient(
    colors: [
      Color(0x803C50E0),
      Color(0x80B478FF),
      Color(0x20F1AC0C),
      Color(0x10FFFFFF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Glass Glare / Shimmer Gradient
  static const LinearGradient glassGlareGradient = LinearGradient(
    colors: [
      Colors.transparent,
      Color(0x1AFFFFFF),
      Color(0x33FFFFFF),
      Color(0x1AFFFFFF),
      Colors.transparent,
    ],
    stops: [0.0, 0.35, 0.5, 0.65, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
