import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/portfolio_controller.dart';
import '../../models/enhanced_portfolio_data.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/responsive.dart';
import '../../widgets/animated_on_scroll.dart';
import '../../widgets/glassmorphism_container.dart';
import '../../widgets/section_container.dart';
import '../../widgets/contact_form.dart';

/// Contact section with clickable social icons and email.
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final isMobile = Responsive.isMobile(context);

    return SectionContainer(
      sectionKey: controller.contactKey,
      title: 'Get In Touch',
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
        Expanded(child: _buildContactInfo(context)),
        const SizedBox(width: 48),
        Expanded(child: ContactForm()),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildContactInfo(context),
        const SizedBox(height: 32),
        ContactForm(),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return GlassmorphismContainer(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
                // Heading
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColors.primaryGradient.createShader(bounds),
                  child: Text(
                    "Let's Connect",
                    style: AppTextStyles.sectionTitle(
                      context,
                    ).copyWith(color: Colors.white, fontSize: 24),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Feel free to reach out for collaborations or just a friendly hello!",
                  style: AppTextStyles.body(context),
                ),
                const SizedBox(height: 32),

                // Contact icons row
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    _ContactIcon(
                      icon: Icons.email_rounded,
                      label: 'Email',
                      onTap: openEmail,
                    ),
                    _ContactIcon(
                      icon: FontAwesomeIcons.linkedin,
                      label: 'LinkedIn',
                      onTap: () => _launchUrl(EnhancedPortfolioData.linkedIn),
                    ),
                    _ContactIcon(
                      icon: FontAwesomeIcons.github,
                      label: 'GitHub',
                      onTap: () => _launchUrl(EnhancedPortfolioData.gitHub),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Email display
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.background.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: SelectableText(
                    EnhancedPortfolioData.email,
                    style: AppTextStyles.chipText(
                      context,
                    ).copyWith(fontSize: 15),
                  ),
                ),
      
              ],
            ),
        
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

Future<void> openEmail() async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: 'karthiofficial0206@gmail.com',
    query: encodeQueryParameters(<String, String>{
      'subject': 'Let\'s Work Together',
      'body': 'Hi Karthick, I would like to connect with you.',
    }),
  );

  if (!await launchUrl(emailUri)) {
    throw 'Could not launch $emailUri';
  }
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

class _ContactIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ContactIcon({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_ContactIcon> createState() => _ContactIconState();
}

class _ContactIconState extends State<_ContactIcon>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _bounceController;
  late Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _bounce = Tween<double>(begin: 0, end: -8).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _bounceController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _bounceController.reverse();
      },
      child: GestureDetector(
        onTap: () {
          HapticFeedback.mediumImpact();
          widget.onTap();
        },
        child: AnimatedBuilder(
          animation: _bounce,
          builder: (context, child) => Transform.translate(
            offset: Offset(0, _bounce.value),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              transform: Matrix4.identity()..scale(_isHovered ? 1.1 : 1.0),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: _isHovered
                          ? AppColors.primaryGradient
                          : null,
                      color: _isHovered
                          ? null
                          : AppColors.cardDark,
                      border: Border.all(
                        color: _isHovered
                            ? AppColors.secondary
                            : AppColors.primary.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                      boxShadow: _isHovered
                          ? [
                              BoxShadow(
                                color: AppColors.glowSecondary.withValues(
                                  alpha: 0.5,
                                ),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ]
                          : [],
                    ),
                    child: Icon(
                      widget.icon,
                      color: _isHovered
                          ? Colors.white
                          : AppColors.textSecondary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.label,
                    style: AppTextStyles.bodySmall(context).copyWith(
                      color:
                          _isHovered ? AppColors.secondary : AppColors.textMuted,
                      fontWeight: _isHovered ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
