import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

/// Controls the app theme with Astra AI color system.
class ThemeController extends GetxController {
  final isDarkMode = true.obs;

  ThemeData get darkTheme => ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.cardDark,
      error: AppColors.error,
    ),
    textTheme: GoogleFonts.plusJakartaSansTextTheme(ThemeData.dark().textTheme),
  );

  ThemeData get lightTheme => ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.lightCard,
      error: AppColors.error,
    ),
    textTheme: GoogleFonts.plusJakartaSansTextTheme(ThemeData.light().textTheme),
  );

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(isDarkMode.value ? darkTheme : lightTheme);
  }
}
