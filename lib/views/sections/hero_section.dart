import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/portfolio_controller.dart';
import '../../models/enhanced_portfolio_data.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/responsive.dart';
import '../../widgets/animated_button.dart';

/// Hero section with animated text reveal and gradient glow.
class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _titleController;
  late AnimationController _subtitleController;
  late AnimationController _buttonController;
  late AnimationController _bgGlowController;

  late Animation<double> _titleFade;
  late Animation<Offset> _titleSlide;
  late Animation<double> _subtitleFade;
  late Animation<Offset> _subtitleSlide;
  late Animation<double> _buttonFade;
  late Animation<double> _bgGlow;

  @override
  void initState() {
    super.initState();

    _titleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _titleFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _titleController, curve: Curves.easeOut));
    _titleSlide = Tween<Offset>(begin: const Offset(0, 50), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _titleController, curve: Curves.easeOutCubic),
        );

    _subtitleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _subtitleFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _subtitleController, curve: Curves.easeOut),
    );
    _subtitleSlide = Tween<Offset>(begin: const Offset(0, 30), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _subtitleController,
            curve: Curves.easeOutCubic,
          ),
        );

    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _buttonFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeOut),
    );

    _bgGlowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);
    _bgGlow = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _bgGlowController, curve: Curves.easeInOut),
    );

    // Stagger the animations
    _titleController.forward();
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _subtitleController.forward();
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) _buttonController.forward();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _buttonController.dispose();
    _bgGlowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final isMobile = Responsive.isMobile(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      key: controller.heroKey,
      width: double.infinity,
      // Use a fixed height rather than minHeight to avoid
      // unbounded constraint issues inside SingleChildScrollView.
      height: screenHeight * 0.9,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background glow orbs
          _buildBackgroundGlow(),

          // Content
          Center(
            child: SizedBox(
              width: Responsive.contentWidth(context),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Greeting + Name
                    AnimatedBuilder(
                      animation: _titleController,
                      builder: (context, _) => Transform.translate(
                        offset: _titleSlide.value,
                        child: Opacity(
                          opacity: _titleFade.value,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello, I'm",
                                style: AppTextStyles.subtitle(context).copyWith(
                                  color: AppColors.secondary,
                                  fontSize: isMobile ? 16 : 20,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ShaderMask(
                                shaderCallback: (bounds) =>
                                    AppColors.heroGradient.createShader(bounds),
                                child: Text(
                                  EnhancedPortfolioData.name,
                                  style: AppTextStyles.heroTitle(
                                    context,
                                  ).copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Title + Tagline
                    AnimatedBuilder(
                      animation: _subtitleController,
                      builder: (context, _) => Transform.translate(
                        offset: _subtitleSlide.value,
                        child: Opacity(
                          opacity: _subtitleFade.value,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                EnhancedPortfolioData.title,
                                style: AppTextStyles.subtitle(context).copyWith(
                                  fontSize: isMobile ? 20 : 28,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: isMobile
                                      ? double.infinity
                                      : MediaQuery.of(context).size.width * 0.5,
                                ),
                                child: Text(
                                  EnhancedPortfolioData.tagline,
                                  style: AppTextStyles.body(context).copyWith(
                                    fontSize: isMobile ? 14 : 16,
                                    height: 1.8,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // CTA Buttons
                    AnimatedBuilder(
                      animation: _buttonController,
                      builder: (context, _) => Opacity(
                        opacity: _buttonFade.value,
                        child: Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: [
                            AnimatedGradientButton(
                              text: 'View Projects',
                              icon: Icons.rocket_launch_rounded,
                              onPressed: () => controller.scrollToSection(3),
                            ),
                            AnimatedGradientButton(
                              text: 'Download Resume',
                              icon: Icons.download_rounded,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundGlow() {
    return AnimatedBuilder(
      animation: _bgGlow,
      builder: (context, _) => Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 100,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: _bgGlow.value * 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 300,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.secondary.withValues(alpha: _bgGlow.value * 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
