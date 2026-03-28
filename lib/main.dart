import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/portfolio_controller.dart';
import 'controllers/theme_controller.dart';
import 'views/home_page.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controllers
    final themeController = Get.put(ThemeController());
    Get.put(PortfolioController());

    return Obx(
      () => GetMaterialApp(
        title: 'Karthick | Flutter Developer',
        debugShowCheckedModeBanner: false,
        theme: themeController.isDarkMode.value
            ? themeController.darkTheme
            : themeController.lightTheme,
        home: const HomePage(),
      ),
    );
  }
}
