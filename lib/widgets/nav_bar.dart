import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/portfolio_controller.dart';
import '../controllers/theme_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/responsive.dart';

/// Top navigation bar matching Astra AI's sleek header style.
class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final themeController = Get.find<ThemeController>();

    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.88),
        border: const Border(
          bottom: BorderSide(color: AppColors.borderSubtle, width: 1),
        ),
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
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

                    // Nav items
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
    return SizedBox(
      height: 48,
      width: 48,
      child: Stack(
        children: [
          // Animated rotating gradient ring
          RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.linear,
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [
                    Colors.transparent,
                    AppColors.primary,
                    AppColors.secondary,
                    AppColors.accent,
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.3, 0.6, 0.9, 1.0],
                ),
              ),
              child: Center(
                child: Container(
                  height: 44,
                  width: 44,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.cardDark,
                  ),
                ),
              ),
            ),
          ),

          // Logo image
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/logo.jpg'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: AppColors.surfaceBorder,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
              return _NavItem(
                label: controller.navItems[index],
                isActive: isActive,
                onTap: () => controller.scrollToSection(index),
              );
            }),
          );
        }),
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
        side: BorderSide(color: AppColors.surfaceBorder, width: 1),
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
                color: AppColors.textMuted.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            ...List.generate(controller.navItems.length, (index) {
              return ListTile(
                title: Text(
                  controller.navItems[index],
                  textAlign: TextAlign.center,
                  style: AppTextStyles.navItem(context).copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
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

class _NavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: widget.isActive
                ? AppColors.primary.withValues(alpha: 0.15)
                : (_isHovered
                    ? AppColors.surfaceElevated
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.isActive
                  ? AppColors.primary
                  : (_isHovered
                      ? AppColors.surfaceBorder
                      : Colors.transparent),
              width: 1.2,
            ),
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.navItem(context).copyWith(
              color: widget.isActive
                  ? Colors.white
                  : (_isHovered
                      ? AppColors.textPrimary
                      : AppColors.textSecondary),
              fontWeight: widget.isActive ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
