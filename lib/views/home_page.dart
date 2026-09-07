import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/portfolio_controller.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/nav_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/particle_background.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/experience_section.dart';
import 'sections/contact_section.dart';

/// Home page assembling all sections in a single scrollable view with Astra AI dark aesthetic.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const Positioned.fill(child: ParticleBackground()),
          Column(
            children: [
              if (!isMobile) const NavBar(),
              Expanded(
                child: Scrollbar(
                  controller: controller.scrollController,
                  child: SingleChildScrollView(
                    controller: controller.scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: const Column(
                      children: [
                        HeroSection(),
                        AboutSection(),
                        SkillsSection(),
                        ProjectsSection(),
                        ExperienceSection(),
                        ContactSection(),
                        _Footer(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: isMobile
          ? Obx(() => BottomNavBar(
                currentIndex: controller.currentSection.value,
                onNavigate: controller.scrollToSection,
              ))
          : null,
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.surfaceBorder, width: 1),
        ),
      ),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) =>
                AppColors.heroGradient.createShader(bounds),
            child: const Text(
              'Karthick',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Crafting modern cross-platform Flutter experiences',
            style: TextStyle(fontSize: 13, color: AppColors.textMuted),
          ),
          const SizedBox(height: 6),
          const Text(
            '© 2026 Karthick. Built with Flutter',
            style: TextStyle(fontSize: 12, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
