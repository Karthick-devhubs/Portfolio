import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/portfolio_controller.dart';
import '../../models/enhanced_portfolio_data.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/file_downloader/file_downloader.dart';
import '../../utils/responsive.dart';
import '../../widgets/animated_button.dart';

/// Hero section with Astra AI tri-color glowing aesthetic and animated reveal.
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
  late AnimationController _floatController;

  late Animation<double> _titleFade;
  late Animation<Offset> _titleSlide;
  late Animation<double> _subtitleFade;
  late Animation<Offset> _subtitleSlide;
  late Animation<double> _buttonFade;
  late Animation<double> _bgGlow;
  late Animation<double> _float;

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
    _titleSlide = Tween<Offset>(begin: const Offset(0, 40), end: Offset.zero)
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
      duration: const Duration(milliseconds: 3200),
    )..repeat(reverse: true);
    _bgGlow = Tween<double>(begin: 0.35, end: 0.75).animate(
      CurvedAnimation(parent: _bgGlowController, curve: Curves.easeInOut),
    );

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);
    _float = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // Stagger animations
    _titleController.forward();
    Future.delayed(const Duration(milliseconds: 350), () {
      if (mounted) _subtitleController.forward();
    });
    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) _buttonController.forward();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _buttonController.dispose();
    _bgGlowController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final isMobile = Responsive.isMobile(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      key: controller.heroKey,
      width: double.infinity,
      height: screenHeight * 0.9,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background atmospheric glow orbs
          _buildBackgroundGlow(),

          // Content
          Center(
            child: SizedBox(
              width: Responsive.contentWidth(context),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: isMobile ? 32 : 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Greeting badge + Name
                    AnimatedBuilder(
                      animation: Listenable.merge([_titleController, _floatController]),
                      builder: (context, _) => Transform.translate(
                        offset: Offset(0, _titleSlide.value.dy + _float.value),
                        child: Opacity(
                          opacity: _titleFade.value,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Astra-style badge pill
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.primary.withValues(alpha: 0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.accent,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Flutter Developer Portfolio",
                                      style: AppTextStyles.chipText(context).copyWith(
                                        color: AppColors.textSecondary,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Name with Astra Harmonious Gradient
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
                                  fontSize: isMobile ? 22 : 30,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: isMobile
                                      ? double.infinity
                                      : MediaQuery.of(context).size.width * 0.52,
                                ),
                                child: Text(
                                  EnhancedPortfolioData.tagline,
                                  style: AppTextStyles.body(context).copyWith(
                                    fontSize: isMobile ? 14 : 16,
                                    height: 1.7,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),

                    // CTA Buttons
                    AnimatedBuilder(
                      animation: _buttonController,
                      builder: (context, _) => Opacity(
                        opacity: _buttonFade.value,
                        child: isMobile
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  AnimatedGradientButton(
                                    text: 'View Projects',
                                    icon: Icons.rocket_launch_rounded,
                                    onPressed: () => controller.scrollToSection(3),
                                  ),
                                  const SizedBox(height: 14),
                                  AnimatedGradientButton(
                                    text: 'Download Resume',
                                    icon: Icons.download_rounded,
                                    isSecondary: true,
                                    onPressed: () => FileDownloader.downloadResume(),
                                  ),
                                ],
                              )
                            : Wrap(
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
                                    isSecondary: true,
                                    onPressed: () => FileDownloader.downloadResume(),
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
          // Blue ambient aura (top right)
          Positioned(
            top: 80,
            right: -80,
            child: Container(
              width: 450,
              height: 450,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: _bgGlow.value * 0.22),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Purple/Amber aura (bottom left)
          Positioned(
            top: 320,
            left: -60,
            child: Container(
              width: 380,
              height: 380,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.secondary.withValues(alpha: _bgGlow.value * 0.16),
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
