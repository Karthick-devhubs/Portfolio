import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Centralized typography for the portfolio app.
class AppTextStyles {
  // Headings — Orbitron for futuristic feel
  static TextStyle heroTitle(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final size = width < 600
        ? 32.0
        : width < 1024
        ? 48.0
        : 64.0;
    return GoogleFonts.orbitron(
      fontSize: size,
      fontWeight: FontWeight.w900,
      color: AppColors.textPrimary,
      letterSpacing: 2,
      height: 1.2,
    );
  }

  static TextStyle sectionTitle(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final size = width < 600 ? 24.0 : 32.0;
    return GoogleFonts.orbitron(
      fontSize: size,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      letterSpacing: 1.5,
    );
  }

  // Subheadings — Exo 2 for clean modern look
  static TextStyle subtitle(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final size = width < 600 ? 16.0 : 20.0;
    return GoogleFonts.exo2(
      fontSize: size,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondary,
      letterSpacing: 0.5,
    );
  }

  // Body — Poppins for readability
  static TextStyle body(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
      height: 1.7,
    );
  }

  static TextStyle bodySmall(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: AppColors.textMuted,
      height: 1.5,
    );
  }

  static TextStyle chipText(BuildContext context) {
    return GoogleFonts.exo2(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: AppColors.secondary,
      letterSpacing: 0.5,
    );
  }

  static TextStyle buttonText(BuildContext context) {
    return GoogleFonts.exo2(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      letterSpacing: 1,
    );
  }

  static TextStyle navItem(BuildContext context) {
    return GoogleFonts.exo2(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.textSecondary,
      letterSpacing: 0.8,
    );
  }

  static TextStyle projectTitle(BuildContext context) {
    return GoogleFonts.orbitron(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      letterSpacing: 1,
    );
  }

  static TextStyle timelineTitle(BuildContext context) {
    return GoogleFonts.exo2(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle timelineSubtitle(BuildContext context) {
    return GoogleFonts.exo2(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.secondary,
    );
  }
}
