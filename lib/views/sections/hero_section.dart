import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/portfolio_controller.dart';
import '../../models/enhanced_portfolio_data.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/file_downloader/file_downloader.dart';
import '../../utils/responsive.dart';
import '../../widgets/animated_button.dart';
import '../../widgets/typewriter_text.dart';

/// Hero section featuring a cyber-aurora aesthetic, animated role typewriter,
/// floating tech badges with physics, and magnetic CTA buttons.
class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late AnimationController _orbitController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOutCubic),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 30),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOutCubic),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.3).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _pulseController.dispose();
    _orbitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      key: controller.heroKey,
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.92,
      ),
      child: Center(
        child: SizedBox(
          width: Responsive.contentWidth(context),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 36 : 64,
            ),
            child: AnimatedBuilder(
              animation: _fadeController,
              builder: (context, child) => Transform.translate(
                offset: _slideAnimation.value,
                child: Opacity(
                  opacity: _fadeAnimation.value,
                  child: isDesktop
                      ? _buildDesktopHero(context, controller)
                      : _buildMobileHero(context, controller),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopHero(
    BuildContext context,
    PortfolioController controller,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Column: Hero Texts & Actions
        Expanded(
          flex: 6,
          child: _buildHeroContent(context, controller),
        ),
        const SizedBox(width: 40),
        // Right Column: Interactive Holographic Orbit Avatar
        Expanded(
          flex: 5,
          child: _buildHeroGraphic(context),
        ),
      ],
    );
  }

  Widget _buildMobileHero(
    BuildContext context,
    PortfolioController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: _buildHeroGraphic(context)),
        const SizedBox(height: 32),
        _buildHeroContent(context, controller),
      ],
    );
  }

  Widget _buildHeroContent(
    BuildContext context,
    PortfolioController controller,
  ) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. Radar Live Status Pill
        _buildRadarStatusBadge(),
        const SizedBox(height: 20),

        // 2. Greeting & Name
        Text(
          "Hi, I'm",
          style: TextStyle(
            fontSize: isMobile ? 20 : 26,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.heroGradient.createShader(bounds),
          child: Text(
            EnhancedPortfolioData.name,
            style: AppTextStyles.heroTitle(context).copyWith(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // 3. Dynamic Typewriter Role
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "I build ",
              style: TextStyle(
                fontSize: isMobile ? 18 : 24,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
              ),
            ),
            TypewriterText(
              texts: const [
                'Flutter Apps',
                'Pixel-Perfect UIs',
                'Cross-Platform Systems',
                'High-Speed Mobile Apps',
                'Scalable Architecture',
              ],
              textStyle: TextStyle(
                fontSize: isMobile ? 18 : 24,
                fontWeight: FontWeight.w800,
                color: AppColors.accentCyan,
                letterSpacing: -0.2,
              ),
              gradient: AppColors.cyberGradient,
            ),
          ],
        ),
        const SizedBox(height: 20),

        // 4. Tagline / Bio
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: Text(
            EnhancedPortfolioData.tagline,
            style: AppTextStyles.body(context).copyWith(
              fontSize: isMobile ? 14.5 : 16,
              height: 1.75,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(height: 36),

        // 5. CTA Buttons
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            AnimatedGradientButton(
              text: 'Explore Projects',
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
        const SizedBox(height: 32),

        // 6. Quick Social Strip
        _buildSocialStrip(context),
      ],
    );
  }

  Widget _buildRadarStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.4),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.4),
            blurRadius: 16,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pulsing Radar Indicator
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) => Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 12 * _pulseAnimation.value,
                  height: 12 * _pulseAnimation.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accent.withValues(
                      alpha: (1.4 - _pulseAnimation.value).clamp(0.0, 0.6),
                    ),
                  ),
                ),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Flutter Developer Portfolio',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialStrip(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSocialIcon(
          icon: FontAwesomeIcons.github,
          url: EnhancedPortfolioData.gitHub,
          tooltip: 'GitHub Profile',
        ),
        const SizedBox(width: 12),
        _buildSocialIcon(
          icon: FontAwesomeIcons.linkedin,
          url: EnhancedPortfolioData.linkedIn,
          tooltip: 'LinkedIn Profile',
        ),
        const SizedBox(width: 12),
        _buildSocialIcon(
          icon: Icons.email_rounded,
          url: 'mailto:${EnhancedPortfolioData.email}',
          tooltip: 'Direct Email',
        ),
      ],
    );
  }

  Widget _buildSocialIcon({
    required dynamic icon,
    required String url,
    required String tooltip,
  }) {
    return _SocialButton(
      icon: icon,
      url: url,
      tooltip: tooltip,
    );
  }

  Widget _buildHeroGraphic(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final size = isMobile ? 260.0 : 340.0;

    return Center(
      child: SizedBox(
        width: size + 60,
        height: size + 60,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer glowing ambient ring
            Container(
              width: size * 0.95,
              height: size * 0.95,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.35),
                    AppColors.secondary.withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            // Rotating sweep aura
            AnimatedBuilder(
              animation: _orbitController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _orbitController.value * 2 * pi,
                  child: Container(
                    width: size + 20,
                    height: size + 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.secondary.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                    ),
                  ),
                );
              },
            ),

            // Center Avatar Container with Gradient Glow Border
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.cyberGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.45),
                    blurRadius: 36,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/my_image.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Orbiting Tech Badges
            _buildOrbitBadge(
              angle: 0.2,
              distance: size * 0.54,
              label: 'Flutter',
              icon: Icons.flutter_dash_rounded,
              color: const Color(0xFF02569B),
            ),
            _buildOrbitBadge(
              angle: 2.1,
              distance: size * 0.54,
              label: 'Dart',
              icon: Icons.code_rounded,
              color: const Color(0xFF0175C2),
            ),
            _buildOrbitBadge(
              angle: 3.9,
              distance: size * 0.54,
              label: 'Firebase',
              icon: Icons.local_fire_department_rounded,
              color: const Color(0xFFFFA000),
            ),
            _buildOrbitBadge(
              angle: 5.2,
              distance: size * 0.54,
              label: 'GetX',
              icon: Icons.flash_on_rounded,
              color: AppColors.secondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrbitBadge({
    required double angle,
    required double distance,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return AnimatedBuilder(
      animation: _orbitController,
      builder: (context, child) {
        final currentAngle = angle + (_orbitController.value * 2 * pi * 0.2);
        final x = cos(currentAngle) * distance;
        final y = sin(currentAngle) * distance;

        return Transform.translate(
          offset: Offset(x, y),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.cardDark.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: color.withValues(alpha: 0.7),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.35),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: 14),
                const SizedBox(width: 5),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SocialButton extends StatefulWidget {
  final dynamic icon;
  final String url;
  final String tooltip;

  const _SocialButton({
    required this.icon,
    required this.url,
    required this.tooltip,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: () async {
            HapticFeedback.lightImpact();
            final uri = Uri.parse(widget.url);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          },
          child: AnimatedScale(
            scale: _isHovered ? 1.12 : 1.0,
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutBack,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: _isHovered ? AppColors.primaryGradient : null,
                color: _isHovered ? null : AppColors.cardDark,
                border: Border.all(
                  color: _isHovered
                      ? AppColors.secondaryLight
                      : AppColors.surfaceBorder,
                  width: 1.2,
                ),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: AppColors.secondary.withValues(alpha: 0.4),
                          blurRadius: 14,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: widget.icon is FaIconData
                    ? FaIcon(
                        widget.icon as FaIconData,
                        color: _isHovered ? Colors.white : AppColors.textSecondary,
                        size: 18,
                      )
                    : Icon(
                        widget.icon as IconData,
                        color: _isHovered ? Colors.white : AppColors.textSecondary,
                        size: 20,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
