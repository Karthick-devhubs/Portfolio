import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/portfolio_controller.dart';
import '../controllers/theme_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/responsive.dart';

/// Top navigation bar — responsive with bottom sheet for mobile.
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
      duration: Duration(seconds: 2),
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
        color: AppColors.background.withValues(alpha: 0.85),
        border: Border(bottom: BorderSide(color: AppColors.primary.withValues(alpha: 0.1))),
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
    child: Stack(
      children: [
        // Logo image with padding to show border
        RotationTransition(
    turns: Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    ),
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          colors: [
            Colors.transparent,
            Colors.blue,
            Colors.purple,
            Colors.pink,
            Colors.transparent,
          ],
          stops: [0.0, 0.3, 0.6, 0.9, 1.0],
        ),
      ),
      child: Center(
        child: Container(
            height: 46,
            width: 46,
          // margin: EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
        ),
      ),
    ),
  ),
        
        // Animated circular border
       Positioned.fill(
  child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
              height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(22),
              image: DecorationImage(
                image: AssetImage('assets/images/logo.jpg'), 
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
),

      ],
    ),
  );
}



  Widget _buildDesktopNav(BuildContext context, PortfolioController controller, ThemeController themeController) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(controller.navItems.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Obx(() {
              final isActive = controller.currentSection.value == index;
              return _NavItem(label: controller.navItems[index], isActive: isActive, onTap: () => controller.scrollToSection(index));
            }),
          );
        }),
        // const SizedBox(width: 8),
        // // Theme toggle
        // Obx(
        //   () => IconButton(
        //     onPressed: themeController.toggleTheme,
        //     icon: Icon(themeController.isDarkMode.value ? Icons.light_mode_rounded : Icons.dark_mode_rounded, color: AppColors.secondary, size: 22),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildMobileNav(BuildContext context, PortfolioController controller, ThemeController themeController) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(
          () => IconButton(
            onPressed: themeController.toggleTheme,
            icon: Icon(themeController.isDarkMode.value ? Icons.light_mode_rounded : Icons.dark_mode_rounded, color: AppColors.secondary, size: 22),
          ),
        ),
        IconButton(
          onPressed: () => _showMobileMenu(context, controller),
          icon: const Icon(Icons.menu_rounded, color: AppColors.textPrimary, size: 28),
        ),
      ],
    );
  }

  void _showMobileMenu(BuildContext context, PortfolioController controller) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardDark,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      transitionAnimationController: AnimationController(vsync: Navigator.of(context), duration: const Duration(milliseconds: 400)),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: AppColors.textMuted, borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(height: 20),
            ...List.generate(controller.navItems.length, (index) {
              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(milliseconds: 300 + (index * 50)),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) => Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: Opacity(
                    opacity: value,
                    child: ListTile(
                      title: Text(controller.navItems[index], textAlign: TextAlign.center, style: AppTextStyles.navItem(context).copyWith(fontSize: 18)),
                      onTap: () {
                        Navigator.pop(context);
                        controller.scrollToSection(index);
                      },
                    ),
                  ),
                ),
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

  const _NavItem({required this.label, required this.isActive, required this.onTap});

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
            color: widget.isActive ? AppColors.primary.withValues(alpha: 0.15) : (_isHovered ? AppColors.primary.withValues(alpha: 0.08) : Colors.transparent),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: widget.isActive ? AppColors.secondary.withValues(alpha: 0.5) : Colors.transparent, width: 1.5),
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.navItem(
              context,
            ).copyWith(color: widget.isActive ? AppColors.secondary : (_isHovered ? AppColors.textPrimary : AppColors.textSecondary)),
          ),
        ),
      ),
    );
  }
}
