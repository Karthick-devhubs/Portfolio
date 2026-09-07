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
import '../../widgets/tilt_card.dart';

/// Experience section featuring a glowing neon laser timeline and rich achievement cards.
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return SectionContainer(
      sectionKey: controller.experienceKey,
      title: 'Work Experience',
      child: Column(
        children: List.generate(EnhancedPortfolioData.experience.length, (index) {
          final exp = EnhancedPortfolioData.experience[index];
          return AnimatedOnScroll(
            delay: Duration(milliseconds: index * 180),
            child: _buildTimelineItem(context, exp),
          );
        }),
      ),
    );
  }

  Widget _buildTimelineItem(BuildContext context, dynamic exp) {
    final isMobile = Responsive.isMobile(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 36),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Laser Indicator (Desktop / Tablet)
          if (!isMobile) ...[
            Column(
              children: [
                // Glowing Pulsing Node
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.cyberGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.7),
                        blurRadius: 16,
                        spreadRadius: 3,
                      ),
                      BoxShadow(
                        color: AppColors.accentCyan.withValues(alpha: 0.5),
                        blurRadius: 24,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Glowing Laser Line
                Container(
                  width: 2.5,
                  height: 220,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.accentCyan,
                        AppColors.primary,
                        AppColors.secondary.withValues(alpha: 0.1),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 28),
          ],

          // Experience Card with 3D Tilt
          Expanded(
            child: TiltCard(
              maxTiltAngle: 5,
              borderRadius: 20,
              child: GlassmorphismContainer(
                borderRadius: 20,
                padding: const EdgeInsets.all(28),
                enableHoverGlow: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header: Role & Duration Badge
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exp.role,
                                style: AppTextStyles.timelineTitle(context).copyWith(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.business_rounded,
                                    size: 16,
                                    color: AppColors.accentCyan,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    exp.company,
                                    style: const TextStyle(
                                      color: AppColors.accentCyan,
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Duration Pill
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.3),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Text(
                            exp.duration,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Achievement Bullet Points
                    ...exp.points.map<Widget>(
                      (point) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 6),
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryLight,
                              ),
                              child: const Icon(
                                Icons.check_rounded,
                                size: 10,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                point,
                                style: AppTextStyles.body(context).copyWith(
                                  fontSize: 14,
                                  height: 1.65,
                                ),
                              ),
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
}
