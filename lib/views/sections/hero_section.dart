import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return _HolographicIdeTerminal(
      orbitController: _orbitController,
      pulseController: _pulseController,
    );
  }
}

/// Interactive Holographic IDE Terminal with 3D perspective tilt,
/// multi-tab code exploration, live Hot-Reload trigger, and orbital holographic tracks.
class _HolographicIdeTerminal extends StatefulWidget {
  final AnimationController orbitController;
  final AnimationController pulseController;

  const _HolographicIdeTerminal({
    required this.orbitController,
    required this.pulseController,
  });

  @override
  State<_HolographicIdeTerminal> createState() => _HolographicIdeTerminalState();
}

class _HolographicIdeTerminalState extends State<_HolographicIdeTerminal> {
  bool _isHovered = false;
  int _selectedTab = 0; // 0: developer.dart, 1: tech_stack.json, 2: terminal.log
  double _tiltX = 0.0;
  double _tiltY = 0.0;
  Offset _sheenPos = const Offset(0.5, 0.5);
  bool _isReloading = false;
  String _statusMessage = '0 errors • Synced';

  void _triggerReload() async {
    if (_isReloading) return;
    HapticFeedback.lightImpact();
    setState(() {
      _isReloading = true;
      _statusMessage = '⚡ Compiling kernel...';
    });
    await Future.delayed(const Duration(milliseconds: 320));
    if (mounted) {
      setState(() {
        _isReloading = false;
        _statusMessage = '✓ Hot Reload in 118ms (synced)';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final cardWidth = isMobile ? 305.0 : 410.0;
    final cardHeight = isMobile ? 240.0 : 285.0;
    final stackWidth = cardWidth + (isMobile ? 55.0 : 85.0);
    final stackHeight = cardHeight + (isMobile ? 60.0 : 85.0);

    return Center(
      child: SizedBox(
        width: stackWidth,
        height: stackHeight,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // 1. Holographic Elliptical Orbital Track Guide
            AnimatedBuilder(
              animation: widget.pulseController,
              builder: (context, child) {
                return CustomPaint(
                  size: Size(stackWidth, stackHeight),
                  painter: _OrbitTrackPainter(
                    pulse: widget.pulseController.value,
                  ),
                );
              },
            ),

            // 2. Ambient Dynamic Glow Aura Backdrop
            AnimatedBuilder(
              animation: widget.pulseController,
              builder: (context, child) {
                final pulse = widget.pulseController.value;
                return Container(
                  width: cardWidth * (0.92 + 0.08 * pulse),
                  height: cardHeight * (0.92 + 0.08 * pulse),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.28 + 0.08 * pulse),
                        AppColors.secondary.withValues(alpha: 0.15),
                        Colors.transparent,
                      ],
                    ),
                  ),
                );
              },
            ),

            // 3. Main Holographic IDE Window with 3D Perspective Tilt & Specular Sheen
            MouseRegion(
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) {
                setState(() {
                  _isHovered = false;
                  _tiltX = 0.0;
                  _tiltY = 0.0;
                });
              },
              onHover: (event) {
                final local = event.localPosition;
                final dx = (local.dx - cardWidth / 2) / (cardWidth / 2);
                final dy = (local.dy - cardHeight / 2) / (cardHeight / 2);
                setState(() {
                  _tiltX = -dy * 0.05;
                  _tiltY = dx * 0.05;
                  _sheenPos = Offset(
                    (local.dx / cardWidth).clamp(0.0, 1.0),
                    (local.dy / cardHeight).clamp(0.0, 1.0),
                  );
                  _isHovered = true;
                });
              },
              child: AnimatedScale(
                scale: _isHovered ? 1.025 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(_tiltX)
                    ..rotateY(_tiltY),
                  alignment: FractionalOffset.center,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    width: cardWidth,
                    height: cardHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF0D0F16),
                          Color(0xFF131622),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(
                        color: _isHovered
                            ? AppColors.secondary.withValues(alpha: 0.7)
                            : AppColors.surfaceBorder,
                        width: 1.3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(
                            alpha: _isHovered ? 0.38 : 0.22,
                          ),
                          blurRadius: _isHovered ? 38 : 24,
                          spreadRadius: _isHovered ? 2 : 0,
                          offset: const Offset(0, 10),
                        ),
                        BoxShadow(
                          color: AppColors.secondary.withValues(
                            alpha: _isHovered ? 0.24 : 0.12,
                          ),
                          blurRadius: 20,
                          spreadRadius: -2,
                        ),
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.7),
                          blurRadius: 30,
                          offset: const Offset(0, 18),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Header / Tab Bar
                              _buildHeaderBar(isMobile),
                              // Code / Terminal Body Surface
                              Expanded(
                                child: _buildEditorSurface(isMobile),
                              ),
                              // Footer Status Bar
                              _buildStatusBar(isMobile),
                            ],
                          ),
                          // Dynamic Glass Specular Sheen Reflection
                          if (_isHovered)
                            Positioned.fill(
                              child: IgnorePointer(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    gradient: RadialGradient(
                                      center: Alignment(
                                        (_sheenPos.dx - 0.5) * 2,
                                        (_sheenPos.dy - 0.5) * 2,
                                      ),
                                      radius: 0.9,
                                      colors: [
                                        Colors.white.withValues(alpha: 0.07),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          // Hot Reload Pulse Flash Overlay
                          if (_isReloading)
                            Positioned.fill(
                              child: IgnorePointer(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: AppColors.primary.withValues(alpha: 0.12),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 4. Orbiting & Floating Tech Satellites (5 High-Impact Badges)
            _buildOrbitBadge(
              angle: 0.25,
              radiusX: cardWidth * 0.55,
              radiusY: cardHeight * 0.55,
              label: 'Flutter 3.x',
              icon: Icons.flutter_dash_rounded,
              color: const Color(0xFF38BDF8),
              isMobile: isMobile,
            ),
            _buildOrbitBadge(
              angle: 1.5,
              radiusX: cardWidth * 0.55,
              radiusY: cardHeight * 0.55,
              label: 'Clean Arch',
              icon: Icons.layers_rounded,
              color: AppColors.secondary,
              isMobile: isMobile,
            ),
            _buildOrbitBadge(
              angle: 2.75,
              radiusX: cardWidth * 0.55,
              radiusY: cardHeight * 0.55,
              label: 'AI & ML',
              icon: Icons.auto_awesome_rounded,
              color: AppColors.accent,
              isMobile: isMobile,
            ),
            _buildOrbitBadge(
              angle: 4.0,
              radiusX: cardWidth * 0.55,
              radiusY: cardHeight * 0.55,
              label: 'Firebase',
              icon: Icons.local_fire_department_rounded,
              color: const Color(0xFFFFA000),
              isMobile: isMobile,
            ),
            _buildOrbitBadge(
              angle: 5.25,
              radiusX: cardWidth * 0.55,
              radiusY: cardHeight * 0.55,
              label: '99.9% Robust',
              icon: Icons.verified_rounded,
              color: const Color(0xFF10B981),
              isMobile: isMobile,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBar(bool isMobile) {
    return Container(
      height: isMobile ? 32 : 36,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        color: Color(0xFF0A0C12),
        border: Border(
          bottom: BorderSide(color: Color(0xFF1B1E2E), width: 1),
        ),
      ),
      child: Row(
        children: [
          // macOS window buttons
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _WindowDot(color: Color(0xFFFF5F56)),
              SizedBox(width: 5),
              _WindowDot(color: Color(0xFFFFBD2E)),
              SizedBox(width: 5),
              _WindowDot(color: Color(0xFF27C93F)),
            ],
          ),
          SizedBox(width: isMobile ? 6 : 10),
          // Scrollable Tabs so it never overflows on any viewport
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTabItem(
                    index: 0,
                    icon: Icons.flutter_dash_rounded,
                    iconColor: const Color(0xFF38BDF8),
                    title: isMobile ? 'dev.dart' : 'developer.dart',
                    isMobile: isMobile,
                  ),
                  const SizedBox(width: 4),
                  _buildTabItem(
                    index: 1,
                    icon: Icons.data_object_rounded,
                    iconColor: AppColors.secondary,
                    title: isMobile ? 'stack.json' : 'tech_stack.json',
                    isMobile: isMobile,
                  ),
                  const SizedBox(width: 4),
                  _buildTabItem(
                    index: 2,
                    icon: Icons.terminal_rounded,
                    iconColor: AppColors.accentCyan,
                    title: isMobile ? 'term.sh' : 'terminal.sh',
                    isMobile: isMobile,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 6),
          // Interactive Hot-Reload / Run Trigger Button
          GestureDetector(
            onTap: _triggerReload,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 6 : 8,
                  vertical: 2.5,
                ),
                decoration: BoxDecoration(
                  color: _isReloading
                      ? AppColors.primary.withValues(alpha: 0.35)
                      : AppColors.cardDark.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _isReloading
                        ? AppColors.primaryLight
                        : AppColors.surfaceBorder,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _isReloading ? Icons.refresh_rounded : Icons.bolt_rounded,
                      size: isMobile ? 11 : 12,
                      color: AppColors.accent,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      _isReloading ? 'SYNC' : '60 FPS',
                      style: GoogleFonts.jetBrainsMono(
                        color: _isReloading
                            ? AppColors.textPrimary
                            : AppColors.textMuted,
                        fontSize: isMobile ? 8.0 : 9.0,
                        fontWeight: FontWeight.w600,
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

  Widget _buildTabItem({
    required int index,
    required IconData icon,
    required Color iconColor,
    required String title,
    required bool isMobile,
  }) {
    final isSelected = _selectedTab == index;

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() => _selectedTab = index);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 5 : 8,
            vertical: 3.5,
          ),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF141724) : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary.withValues(alpha: 0.35)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: isMobile ? 10 : 12, color: iconColor),
              const SizedBox(width: 4),
              Text(
                title,
                style: GoogleFonts.jetBrainsMono(
                  color: isSelected
                      ? AppColors.textPrimary
                      : AppColors.textMuted,
                  fontSize: isMobile ? 8.5 : 10.0,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              if (isSelected) ...[
                const SizedBox(width: 4),
                Container(
                  width: 4.5,
                  height: 4.5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.success,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditorSurface(bool isMobile) {
    final fontSz = isMobile ? 9.5 : 11.0;
    final lineSpacing = isMobile ? 1.35 : 1.45;

    switch (_selectedTab) {
      case 1:
        return _buildJsonCodeView(fontSz, lineSpacing, isMobile);
      case 2:
        return _buildTerminalLogView(fontSz, lineSpacing, isMobile);
      case 0:
      default:
        return _buildDartCodeView(fontSz, lineSpacing, isMobile);
    }
  }

  Widget _buildDartCodeView(double fontSz, double lineSpacing, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 12,
        vertical: isMobile ? 6 : 8,
      ),
      color: const Color(0xFF090A10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Line numbers column
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(7, (index) {
              return Text(
                '${index + 1}',
                style: GoogleFonts.jetBrainsMono(
                  color: const Color(0xFF3F465B),
                  fontSize: fontSz,
                  height: lineSpacing,
                  fontWeight: FontWeight.w500,
                ),
              );
            }),
          ),
          SizedBox(width: isMobile ? 8 : 12),
          // Vertical gutter divider
          Container(
            width: 1,
            height: isMobile ? 120 : 145,
            color: const Color(0xFF1B1E2D),
          ),
          SizedBox(width: isMobile ? 8 : 12),
          // Syntax-highlighted code lines
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCodeLine([
                  const _CodeSpan('class ', Color(0xFFB478FF), FontWeight.bold),
                  const _CodeSpan('FlutterArchitect ', Color(0xFF5B8DEF), FontWeight.bold),
                  const _CodeSpan('{', Colors.white70),
                ], fontSz, lineSpacing),
                _buildCodeLine([
                  const _CodeSpan('  final ', Color(0xFFB478FF)),
                  const _CodeSpan('name = ', AppColors.textSecondary),
                  const _CodeSpan("'${EnhancedPortfolioData.name}'", Color(0xFFF1AC0C)),
                  const _CodeSpan(';', Colors.white54),
                ], fontSz, lineSpacing),
                _buildCodeLine([
                  const _CodeSpan('  final ', Color(0xFFB478FF)),
                  const _CodeSpan('role = ', AppColors.textSecondary),
                  const _CodeSpan("'Senior Engineer'", Color(0xFFF1AC0C)),
                  const _CodeSpan(';', Colors.white54),
                ], fontSz, lineSpacing),
                _buildCodeLine([
                  const _CodeSpan('  final ', Color(0xFFB478FF)),
                  const _CodeSpan('architecture = ', AppColors.textSecondary),
                  const _CodeSpan("'Clean + MVVM'", Color(0xFF00F5D4)),
                  const _CodeSpan(';', Colors.white54),
                ], fontSz, lineSpacing),
                _buildCodeLine([
                  const _CodeSpan('  bool ', Color(0xFFB478FF)),
                  const _CodeSpan('get ready => ', AppColors.textSecondary),
                  const _CodeSpan('true', Color(0xFF10B981), FontWeight.bold),
                  const _CodeSpan(';', Colors.white54),
                ], fontSz, lineSpacing),
                _buildCodeLine([
                  const _CodeSpan('  void ', Color(0xFFB478FF)),
                  const _CodeSpan('deploy', Color(0xFF38BDF8), FontWeight.w600),
                  const _CodeSpan('() => ', AppColors.textSecondary),
                  const _CodeSpan('deliverImpact();', Color(0xFF5B8DEF)),
                ], fontSz, lineSpacing, showCursor: true),
                _buildCodeLine([
                  const _CodeSpan('}', Colors.white70),
                ], fontSz, lineSpacing),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJsonCodeView(double fontSz, double lineSpacing, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 12,
        vertical: isMobile ? 6 : 8,
      ),
      color: const Color(0xFF090A10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(7, (index) {
              return Text(
                '${index + 1}',
                style: GoogleFonts.jetBrainsMono(
                  color: const Color(0xFF3F465B),
                  fontSize: fontSz,
                  height: lineSpacing,
                  fontWeight: FontWeight.w500,
                ),
              );
            }),
          ),
          SizedBox(width: isMobile ? 8 : 12),
          Container(
            width: 1,
            height: isMobile ? 120 : 145,
            color: const Color(0xFF1B1E2D),
          ),
          SizedBox(width: isMobile ? 8 : 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCodeLine([
                  const _CodeSpan('{', Colors.white70),
                ], fontSz, lineSpacing),
                _buildCodeLine([
                  const _CodeSpan('  "core": ', Color(0xFFB478FF)),
                  const _CodeSpan('"Flutter 3.x / Dart"', Color(0xFFF1AC0C)),
                  const _CodeSpan(',', Colors.white54),
                ], fontSz, lineSpacing),
                _buildCodeLine([
                  const _CodeSpan('  "state": ', Color(0xFFB478FF)),
                  const _CodeSpan('["GetX", "Bloc", "Riverpod"]', Color(0xFF00F5D4)),
                  const _CodeSpan(',', Colors.white54),
                ], fontSz, lineSpacing),
                _buildCodeLine([
                  const _CodeSpan('  "backend": ', Color(0xFFB478FF)),
                  const _CodeSpan('["Firebase", "REST", "GraphQL"]', Color(0xFF00F5D4)),
                  const _CodeSpan(',', Colors.white54),
                ], fontSz, lineSpacing),
                _buildCodeLine([
                  const _CodeSpan('  "ai_tools": ', Color(0xFFB478FF)),
                  const _CodeSpan('["Agentic AI", "LLM APIs"]', Color(0xFF10B981)),
                  const _CodeSpan(',', Colors.white54),
                ], fontSz, lineSpacing),
                _buildCodeLine([
                  const _CodeSpan('  "uptime": ', Color(0xFFB478FF)),
                  const _CodeSpan('"99.9% Crash-Free"', Color(0xFFF1AC0C)),
                ], fontSz, lineSpacing, showCursor: true),
                _buildCodeLine([
                  const _CodeSpan('}', Colors.white70),
                ], fontSz, lineSpacing),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTerminalLogView(double fontSz, double lineSpacing, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 12,
        vertical: isMobile ? 6 : 8,
      ),
      color: const Color(0xFF06070B),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(6, (index) {
              return Text(
                '${index + 1}',
                style: GoogleFonts.jetBrainsMono(
                  color: const Color(0xFF3F465B),
                  fontSize: fontSz,
                  height: lineSpacing,
                  fontWeight: FontWeight.w500,
                ),
              );
            }),
          ),
          SizedBox(width: isMobile ? 8 : 12),
          Container(
            width: 1,
            height: isMobile ? 120 : 145,
            color: const Color(0xFF1B1E2D),
          ),
          SizedBox(width: isMobile ? 8 : 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCodeLine([
                  const _CodeSpan('\$ ', Color(0xFF818CF8), FontWeight.bold),
                  const _CodeSpan('flutter build web --release', Color(0xFFE2E8F0)),
                ], fontSz, lineSpacing),
                _buildCodeLine([
                  const _CodeSpan('[✓] ', Color(0xFF10B981)),
                  const _CodeSpan('Compiling kernel... ', AppColors.textSecondary),
                  const _CodeSpan('[0.9s]', Color(0xFF38BDF8)),
                ], fontSz, lineSpacing),
                _buildCodeLine([
                  const _CodeSpan('[✓] ', Color(0xFF10B981)),
                  const _CodeSpan('Zero jank • 60 FPS smooth', Color(0xFF00F5D4)),
                ], fontSz, lineSpacing),
                _buildCodeLine([
                  const _CodeSpan('[✓] ', Color(0xFF10B981)),
                  const _CodeSpan('All 48 test suites passed', AppColors.textSecondary),
                ], fontSz, lineSpacing),
                _buildCodeLine([
                  const _CodeSpan('🚀 ', Colors.white),
                  const _CodeSpan('Live: Ready for Production!', Color(0xFFF1AC0C), FontWeight.bold),
                ], fontSz, lineSpacing, showCursor: true),
                _buildCodeLine([
                  const _CodeSpan('\$ ', Color(0xFF818CF8)),
                  const _CodeSpan('listening on port 8080...', Color(0xFF64748B)),
                ], fontSz, lineSpacing),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeLine(
    List<_CodeSpan> spans,
    double fontSize,
    double height, {
    bool showCursor = false,
  }) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.jetBrainsMono(
          fontSize: fontSize,
          height: height,
          letterSpacing: 0.1,
        ),
        children: [
          ...spans.map(
            (s) => TextSpan(
              text: s.text,
              style: TextStyle(
                color: s.color,
                fontWeight: s.fontWeight ?? FontWeight.normal,
              ),
            ),
          ),
          if (showCursor)
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: AnimatedBuilder(
                animation: widget.pulseController,
                builder: (context, child) {
                  return Opacity(
                    opacity: widget.pulseController.value > 0.5 ? 1.0 : 0.0,
                    child: Container(
                      width: 6,
                      height: fontSize * 1.15,
                      margin: const EdgeInsets.only(left: 2),
                      decoration: BoxDecoration(
                        color: AppColors.accentCyan,
                        borderRadius: BorderRadius.circular(1.5),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accentCyan.withValues(alpha: 0.6),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatusBar(bool isMobile) {
    return Container(
      height: isMobile ? 21 : 23,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        color: Color(0xFF07080D),
        border: Border(
          top: BorderSide(color: Color(0xFF171A27), width: 1),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.fork_right_rounded,
            size: isMobile ? 10 : 12,
            color: const Color(0xFF818CF8),
          ),
          const SizedBox(width: 3),
          Text(
            'main*',
            style: GoogleFonts.jetBrainsMono(
              color: const Color(0xFF818CF8),
              fontSize: isMobile ? 8.5 : 9.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            _isReloading
                ? Icons.hourglass_top_rounded
                : Icons.check_circle_outline_rounded,
            size: isMobile ? 9.5 : 11,
            color: _isReloading ? AppColors.accent : AppColors.success,
          ),
          const SizedBox(width: 3),
          Expanded(
            child: Text(
              _statusMessage,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.jetBrainsMono(
                color: _isReloading ? AppColors.accent : AppColors.textMuted,
                fontSize: isMobile ? 8.0 : 9.0,
              ),
            ),
          ),
          Text(
            'Dart 3.5 • UTF-8',
            style: GoogleFonts.jetBrainsMono(
              color: AppColors.textTertiary,
              fontSize: isMobile ? 8.0 : 9.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrbitBadge({
    required double angle,
    required double radiusX,
    required double radiusY,
    required String label,
    required IconData icon,
    required Color color,
    required bool isMobile,
  }) {
    return AnimatedBuilder(
      animation: widget.orbitController,
      builder: (context, child) {
        final t = widget.orbitController.value * 2 * pi;
        final currentAngle = angle + (t * 0.22);
        final x = cos(currentAngle) * (radiusX + 8 * sin(t * 2));
        final y = sin(currentAngle) * (radiusY + 6 * cos(t * 2));

        return Transform.translate(
          offset: Offset(x, y),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 7 : 10,
              vertical: isMobile ? 4 : 5.5,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF10121C).withValues(alpha: 0.94),
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                color: color.withValues(alpha: 0.65),
                width: 1.1,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.32),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: isMobile ? 11 : 13),
                const SizedBox(width: 4.5),
                Text(
                  label,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: isMobile ? 9.5 : 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
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

/// Subtle holographic elliptical orbit track painter
class _OrbitTrackPainter extends CustomPainter {
  final double pulse;

  _OrbitTrackPainter({required this.pulse});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint1 = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.08 + 0.04 * pulse)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final paint2 = Paint()
      ..color = AppColors.secondary.withValues(alpha: 0.06 + 0.03 * pulse)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawOval(
      Rect.fromCenter(
        center: center,
        width: size.width * 0.94,
        height: size.height * 0.86,
      ),
      paint1,
    );

    canvas.drawOval(
      Rect.fromCenter(
        center: center,
        width: size.width * 0.78,
        height: size.height * 0.70,
      ),
      paint2,
    );
  }

  @override
  bool shouldRepaint(covariant _OrbitTrackPainter oldDelegate) =>
      oldDelegate.pulse != pulse;
}

class _WindowDot extends StatelessWidget {
  final Color color;

  const _WindowDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8.5,
      height: 8.5,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 3,
          ),
        ],
      ),
    );
  }
}

class _CodeSpan {
  final String text;
  final Color color;
  final FontWeight? fontWeight;

  const _CodeSpan(this.text, this.color, [this.fontWeight]);
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
