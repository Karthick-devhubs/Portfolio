import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/portfolio_controller.dart';
import '../controllers/theme_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/responsive.dart';

/// Top navigation bar — responsive with bottom sheet for mobile.
class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final themeController = Get.find<ThemeController>();

    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.85),
        border: Border(
          bottom: BorderSide(color: AppColors.primary.withValues(alpha: 0.1)),
        ),
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo
                    _buildLogo(context),

                    // Nav items or menu button
                    if (Responsive.isDesktop(context))
                      _buildDesktopNav(context, controller, themeController)
                    else
                      _buildMobileNav(context, controller, themeController),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
    
      decoration:  BoxDecoration(
         color: Colors.transparent,
        borderRadius: BorderRadius.circular(40),
        image: DecorationImage(
          image: AssetImage('assets/images/logo_light.png'),
          fit: BoxFit.fill,
        ),
      ),
      // child: Image.asset('assets/images/logo.png',
      //     height: 30,
      //     fit: BoxFit.contain,
      //    ),
    );
  }

  Widget _buildDesktopNav(
    BuildContext context,
    PortfolioController controller,
    ThemeController themeController,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(controller.navItems.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Obx(() {
              final isActive = controller.currentSection.value == index;
              return TextButton(
                onPressed: () => controller.scrollToSection(index),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  controller.navItems[index],
                  style: AppTextStyles.navItem(context).copyWith(
                    color: isActive
                        ? AppColors.secondary
                        : AppColors.textSecondary,
                  ),
                ),
              );
            }),
          );
        }),
        const SizedBox(width: 8),
        // Theme toggle
        Obx(
          () => IconButton(
            onPressed: themeController.toggleTheme,
            icon: Icon(
              themeController.isDarkMode.value
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              color: AppColors.secondary,
              size: 22,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileNav(
    BuildContext context,
    PortfolioController controller,
    ThemeController themeController,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(
          () => IconButton(
            onPressed: themeController.toggleTheme,
            icon: Icon(
              themeController.isDarkMode.value
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              color: AppColors.secondary,
              size: 22,
            ),
          ),
        ),
        IconButton(
          onPressed: () => _showMobileMenu(context, controller),
          icon: const Icon(
            Icons.menu_rounded,
            color: AppColors.textPrimary,
            size: 28,
          ),
        ),
      ],
    );
  }

  void _showMobileMenu(BuildContext context, PortfolioController controller) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textMuted,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            ...List.generate(controller.navItems.length, (index) {
              return ListTile(
                title: Text(
                  controller.navItems[index],
                  textAlign: TextAlign.center,
                  style: AppTextStyles.navItem(context).copyWith(fontSize: 18),
                ),
                onTap: () {
                  Navigator.pop(context);
                  controller.scrollToSection(index);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
