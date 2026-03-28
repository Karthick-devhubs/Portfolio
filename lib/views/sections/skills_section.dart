import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/portfolio_controller.dart';
import '../../models/enhanced_portfolio_data.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/animated_on_scroll.dart';
import '../../widgets/section_container.dart';
import '../../widgets/skill_chip.dart';

/// Skills section organized by category with animated chips.
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return SectionContainer(
      sectionKey: controller.skillsKey,
      title: 'Skills',
      child: Column(
        children: List.generate(EnhancedPortfolioData.enhancedSkills.length, (index) {
          final category = EnhancedPortfolioData.enhancedSkills[index];
          return AnimatedOnScroll(
            delay: Duration(milliseconds: index * 100),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category label
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 20,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        category.category,
                        style: AppTextStyles.subtitle(context).copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Skill chips
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: category.skills
                        .map((s) => SkillChip(label: s))
                        .toList(),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
