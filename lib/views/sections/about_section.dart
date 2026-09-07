import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/portfolio_controller.dart';
import '../../models/enhanced_portfolio_data.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/responsive.dart';
import '../../widgets/animated_counter.dart';
import '../../widgets/animated_on_scroll.dart';
import '../../widgets/glassmorphism_container.dart';
import '../../widgets/section_container.dart';
import '../../widgets/tilt_card.dart';

/// About Me section with Astra AI glassmorphic styling and ambient lighting.
class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotateController;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
    _rotation = Tween<double>(begin: 0, end: 1).animate(_rotateController);
  }

  @override
  void dispose() {
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final isMobile = Responsive.isMobile(context);

    return SectionContainer(
      sectionKey: controller.aboutKey,
      title: 'About Me',
      child: AnimatedOnScroll(
        child: Column(
          children: [
            isMobile
                ? _buildMobileLayout(context)
                : _buildDesktopLayout(context),
            const SizedBox(height: 48),
            // Core Engineering Pillars
            _buildEngineeringPillars(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar with Astra gradient border & aura
        _buildAvatar(context),
        const SizedBox(width: 48),
        // About content
        Expanded(child: _buildBioContent(context)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: 0.8 + (0.2 * value),
              child: Opacity(opacity: value, child: child),
            );
          },
          child: _buildAvatar(context),
        ),
        const SizedBox(height: 32),
        _buildBioContent(context),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotation,
      builder: (context, child) => Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.primaryGradient,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.35),
              blurRadius: 28,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: ClipOval(
            child: Image.asset(
              'assets/images/my_image.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBioContent(BuildContext context) {
    return GlassmorphismContainer(
      padding: const EdgeInsets.all(32),
      enableHoverGlow: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) =>
                AppColors.heroGradient.createShader(bounds),
            child: Text(
              "Building High-Impact Cross-Platform Experiences",
              style: AppTextStyles.subtitle(context).copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 22,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            EnhancedPortfolioData.about,
            style: AppTextStyles.body(context).copyWith(
              fontSize: 15.5,
              height: 1.8,
            ),
          ),
          const SizedBox(height: 32),

          // Animated Stat Counters
          Wrap(
            spacing: 36,
            runSpacing: 20,
            children: [
              _buildStatCounter(context, 1, '+', 'Years Experience'),
              _buildStatCounter(context, 6, '+', 'Production Apps'),
              _buildStatCounter(context, 10, '+', 'Tech Stacks'),
              _buildStatCounter(context, 100, '%', 'Clean Code Architecture'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCounter(
    BuildContext context,
    int value,
    String suffix,
    String label,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCounter(
          targetValue: value,
          suffix: suffix,
          style: AppTextStyles.sectionTitle(context).copyWith(
            fontSize: 32,
            fontWeight: FontWeight.w800,
          ),
          gradient: AppColors.cyberGradient,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.bodySmall(context).copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildEngineeringPillars(BuildContext context) {
    final pillars = [
      _PillarItem(
        icon: Icons.architecture_rounded,
        title: 'Clean Architecture',
        description:
            'Modular, testable code separating domain, data, and presentation layers for long-term scalability.',
        color: AppColors.primary,
      ),
      _PillarItem(
        icon: Icons.speed_rounded,
        title: '60/120 FPS Performance',
        description:
            'Optimized widget build cycles, lazy rendering, and lightweight state management with GetX.',
        color: AppColors.accentCyan,
      ),
      _PillarItem(
        icon: Icons.auto_awesome_rounded,
        title: 'Pixel-Perfect UI/UX',
        description:
            'Fluid animations, dynamic micro-interactions, responsive grids, and modern cyber aesthetics.',
        color: AppColors.secondary,
      ),
      _PillarItem(
        icon: Icons.cloud_sync_rounded,
        title: 'API & Cloud Integration',
        description:
            'Real-time WebSocket & Firebase synchronization, secure REST APIs, and background job handling.',
        color: AppColors.accent,
      ),
    ];

    final isMobile = Responsive.isMobile(context);
    final width = Responsive.contentWidth(context);
    final cardWidth = isMobile ? width : (width - 48) / 2;

    return Wrap(
      spacing: 24,
      runSpacing: 24,
      children: pillars.map((pillar) {
        return SizedBox(
          width: cardWidth,
          child: TiltCard(
            maxTiltAngle: 6,
            borderRadius: 18,
            child: GlassmorphismContainer(
              borderRadius: 18,
              padding: const EdgeInsets.all(24),
              enableHoverGlow: true,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: pillar.color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: pillar.color.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Center(
                      child: Icon(pillar.icon, color: pillar.color, size: 24),
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pillar.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          pillar.description,
                          style: AppTextStyles.bodySmall(context).copyWith(
                            fontSize: 13.5,
                            height: 1.6,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _PillarItem {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  _PillarItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}
