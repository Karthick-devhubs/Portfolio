import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

/// Controls the app theme (light/dark toggle).
class ThemeController extends GetxController {
  final isDarkMode = true.obs;

  ThemeData get darkTheme => ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.cardDark,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
  );

  ThemeData get lightTheme => ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.lightCard,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
  );

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(isDarkMode.value ? darkTheme : lightTheme);
  }
}
