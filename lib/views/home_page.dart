import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/portfolio_controller.dart';
import '../models/enhanced_portfolio_data.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/back_to_top_button.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/nav_bar.dart';
import '../widgets/particle_background.dart';
import '../widgets/scroll_progress_bar.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/experience_section.dart';
import 'sections/hero_section.dart';
import 'sections/projects_section.dart';
import 'sections/skills_section.dart';

/// Main single-page portfolio layout with dynamic scroll progress,
/// auto-detecting section navbar, ambient celestial background, and back-to-top FAB.
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
          // 1. Cosmic Aurora & Interactive Particle Matrix
          const Positioned.fill(child: ParticleBackground()),

          // 2. Main Scroll Content
          Column(
            children: [
              // Top Pinned Navigation Bar (Desktop / Tablet)
              if (!isMobile) const NavBar(),

              // Scroll View Body
              Expanded(
                child: Scrollbar(
                  controller: controller.scrollController,
                  child: SingleChildScrollView(
                    controller: controller.scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: const [
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

          // 3. Top Scroll Depth Progress Line
          Obx(() => ScrollProgressBar(
                progress: controller.scrollProgress.value,
              )),

          // 4. Floating Back-To-Top Button
          Positioned(
            right: 24,
            bottom: isMobile ? 80 : 28,
            child: Obx(() => BackToTopButton(
                  progress: controller.scrollProgress.value,
                  isVisible: controller.showBackToTop.value,
                  onTap: controller.scrollToTop,
                )),
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
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      decoration: const BoxDecoration(
        color: AppColors.backgroundSecondary,
        border: Border(
          top: BorderSide(color: AppColors.surfaceBorder, width: 1),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              // Brand Heading
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppColors.heroGradient.createShader(bounds),
                child: const Text(
                  'Karthick',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Crafting scalable, high-performance cross-platform Flutter experiences.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textMuted,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 20),

              // Social Badges Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _FooterIcon(
                    icon: FontAwesomeIcons.github,
                    url: EnhancedPortfolioData.gitHub,
                  ),
                  const SizedBox(width: 16),
                  _FooterIcon(
                    icon: FontAwesomeIcons.linkedin,
                    url: EnhancedPortfolioData.linkedIn,
                  ),
                  const SizedBox(width: 16),
                  _FooterIcon(
                    icon: Icons.email_rounded,
                    url: 'mailto:${EnhancedPortfolioData.email}',
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Copyright
              const Text(
                '© 2026 Karthick. Built with Flutter & Dart.',
                style: TextStyle(fontSize: 12.5, color: AppColors.textTertiary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterIcon extends StatelessWidget {
  final dynamic icon;
  final String url;

  const _FooterIcon({required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon is FaIconData
          ? FaIcon(icon as FaIconData, size: 18)
          : Icon(icon as IconData, size: 20),
      color: AppColors.textMuted,
      hoverColor: AppColors.primaryLight,
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
    );
  }
}
