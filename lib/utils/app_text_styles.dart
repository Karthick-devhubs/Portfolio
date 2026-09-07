import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Centralized typography for the portfolio app.
class AppTextStyles {
  // Headings — Bold, modern, punchy display font
  static TextStyle heroTitle(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final size = width < 600
        ? 36.0
        : width < 1024
            ? 54.0
            : 68.0;
    return GoogleFonts.plusJakartaSans(
      fontSize: size,
      fontWeight: FontWeight.w800,
      color: AppColors.textPrimary,
      letterSpacing: -1.5,
      height: 1.12,
    );
  }

  static TextStyle sectionTitle(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final size = width < 600 ? 28.0 : 38.0;
    return GoogleFonts.plusJakartaSans(
      fontSize: size,
      fontWeight: FontWeight.w800,
      color: AppColors.textPrimary,
      letterSpacing: -0.8,
    );
  }

  // Subheadings
  static TextStyle subtitle(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final size = width < 600 ? 18.0 : 22.0;
    return GoogleFonts.plusJakartaSans(
      fontSize: size,
      fontWeight: FontWeight.w700,
      color: AppColors.textSecondary,
      letterSpacing: -0.3,
    );
  }

  // Body
  static TextStyle body(BuildContext context) {
    return GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
      height: 1.7,
    );
  }

  static TextStyle bodySmall(BuildContext context) {
    return GoogleFonts.inter(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: AppColors.textMuted,
      height: 1.5,
    );
  }

  static TextStyle chipText(BuildContext context) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: AppColors.secondary,
      letterSpacing: 0.2,
    );
  }

  static TextStyle buttonText(BuildContext context) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      letterSpacing: 0.3,
    );
  }

  static TextStyle navItem(BuildContext context) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 14.5,
      fontWeight: FontWeight.w600,
      color: AppColors.textSecondary,
      letterSpacing: 0.1,
    );
  }

  static TextStyle projectTitle(BuildContext context) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      letterSpacing: -0.4,
    );
  }

  static TextStyle timelineTitle(BuildContext context) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      letterSpacing: -0.2,
    );
  }

  static TextStyle timelineSubtitle(BuildContext context) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.secondary,
    );
  }

  static TextStyle code(BuildContext context) {
    return GoogleFonts.firaCode(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: AppColors.accentCyan,
    );
  }
}
