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

/// Experience section with a vertical timeline UI.
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return SectionContainer(
      sectionKey: controller.experienceKey,
      title: 'Experience',
      child: Column(
        children: List.generate(EnhancedPortfolioData.experience.length, (index) {
          final exp = EnhancedPortfolioData.experience[index];
          return AnimatedOnScroll(
            delay: Duration(milliseconds: index * 200),
            child: _buildTimelineItem(context, exp),
          );
        }),
      ),
    );
  }

  Widget _buildTimelineItem(BuildContext context, dynamic exp) {
    final isMobile = Responsive.isMobile(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator (desktop/tablet only)
          if (!isMobile) ...[
            Column(
              children: [
                // Glowing dot
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.primaryGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                // Vertical line
                Container(
                  width: 2,
                  height: 120,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withValues(alpha: 0.1),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 24),
          ],

          // Content card
          Expanded(
            child: GlassmorphismContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Duration badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      exp.duration,
                      style: AppTextStyles.chipText(
                        context,
                      ).copyWith(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Role
                  Text(exp.role, style: AppTextStyles.timelineTitle(context)),
                  const SizedBox(height: 4),

                  // Company
                  Text(
                    exp.company,
                    style: AppTextStyles.timelineSubtitle(context),
                  ),
                  const SizedBox(height: 16),

                  // Bullet points
                  ...exp.points.map<Widget>(
                    (point) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.secondary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              point,
                              style: AppTextStyles.body(context),
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
        ],
      ),
    );
  }
}
