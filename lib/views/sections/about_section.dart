import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/portfolio_controller.dart';
import '../../models/enhanced_portfolio_data.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/responsive.dart';
import '../../widgets/animated_on_scroll.dart';
import '../../widgets/glassmorphism_container.dart';
import '../../widgets/section_container.dart';

/// About Me section with glassmorphic card.
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
        child: isMobile
            ? _buildMobileLayout(context)
            : _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar placeholder with glow
        _buildAvatar(context),
        const SizedBox(width: 48),
        // About content
        Expanded(child: _buildContent(context)),
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
        _buildContent(context),
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
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: 30,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/my_image.png',
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}


  Widget _buildContent(BuildContext context) {
    return GlassmorphismContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) =>
                AppColors.primaryGradient.createShader(bounds),
            child: Text(
              "Who I Am",
              style: AppTextStyles.subtitle(
                context,
              ).copyWith(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 16),
          Text(EnhancedPortfolioData.about, style: AppTextStyles.body(context)),
          const SizedBox(height: 24),
          // Quick stats
          Wrap(
            spacing: 24,
            runSpacing: 16,
            children: [
              _buildStat(context, '1+', 'Years Exp'),
              _buildStat(context, '6+', 'Projects'),
              _buildStat(context, '10+', 'Tech Stacks'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(BuildContext context, String value, String label) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.primaryGradient.createShader(bounds),
          child: Text(
            value,
            style: AppTextStyles.sectionTitle(
              context,
            ).copyWith(color: Colors.white, fontSize: 28),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.bodySmall(context)),
      ],
    );
  }
}
