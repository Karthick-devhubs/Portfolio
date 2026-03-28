import 'package:flutter/material.dart';

/// Centralized color palette for the portfolio app.
class AppColors {
  // Primary palette
  static const Color primary = Color(0xFF6C63FF);
  static const Color secondary = Color(0xFF00D1FF);
  static const Color background = Color(0xFF0F0F1A);
  static const Color cardDark = Color(0xFF1A1A2E);
  static const Color surface = Color(0xFF16162A);

  // Text colors
  static const Color textPrimary = Color(0xFFEAEAEA);
  static const Color textSecondary = Color(0xFFB0B0C0);
  static const Color textMuted = Color(0xFF6E6E8A);

  // Accent & glow
  static const Color glowPrimary = Color(0x406C63FF);
  static const Color glowSecondary = Color(0x4000D1FF);

  // Light theme
  static const Color lightBackground = Color(0xFFF5F5FA);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF1A1A2E);
  static const Color lightTextSecondary = Color(0xFF4A4A6A);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF1A1A2E), Color(0xFF0F0F1A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF00D1FF), Color(0xFF6C63FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
