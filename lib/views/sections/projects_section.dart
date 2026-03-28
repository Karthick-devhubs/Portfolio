import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/portfolio_controller.dart';
import '../../models/enhanced_portfolio_data.dart';
import '../../utils/responsive.dart';
import '../../widgets/animated_on_scroll.dart';
import '../../widgets/project_card.dart';
import '../../widgets/section_container.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../models/enhanced_models.dart';

/// Projects section with responsive grid of project cards.
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final crossAxisCount = Responsive.value<int>(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    );
    final availableWidth = Responsive.contentWidth(context);

    return SectionContainer(
      sectionKey: controller.projectsKey,
      title: 'Projects',
      child: Column(
        children: [
          _buildFilters(context),
          const SizedBox(height: 32),
          _buildCards(context, crossAxisCount, availableWidth),
        ],
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
    final categories = ['All', 'Finance', 'Healthcare', 'Education', 'Business', 'Health & Fitness', 'IoT'];
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          final isAll = category == 'All';
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilterChip(
              label: Text(category),
              selected: isAll,
              onSelected: (selected) {
                // Filter logic can be added here
              },
              backgroundColor: AppColors.surface,
              selectedColor: AppColors.primary.withOpacity(0.2),
              checkmarkColor: AppColors.secondary,
              labelStyle: TextStyle(
                color: isAll ? AppColors.secondary : AppColors.textSecondary,
                fontWeight: isAll ? FontWeight.w600 : FontWeight.w400,
              ),
              side: BorderSide(
                color: isAll ? AppColors.primary : AppColors.primary.withOpacity(0.2),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCards(
    BuildContext context,
    int crossAxisCount,
    double availableWidth,
  ) {
    if (crossAxisCount == 1) {
      // Stack cards vertically on mobile
      return Column(
        children: List.generate(EnhancedPortfolioData.projects.length, (index) {
          return AnimatedOnScroll(
            delay: Duration(milliseconds: index * 150),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: ProjectCard(
                project: EnhancedPortfolioData.projects[index],
                index: index,
              ),
            ),
          );
        }),
      );
    }

    // Grid for tablet/desktop
    final spacing = 24.0;
    final cardWidth =
        (availableWidth - (crossAxisCount - 1) * spacing) / crossAxisCount;

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: List.generate(EnhancedPortfolioData.projects.length, (index) {
        return AnimatedOnScroll(
          delay: Duration(milliseconds: index * 150),
          child: SizedBox(
            width: cardWidth,
            child: ProjectCard(
              project: EnhancedPortfolioData.projects[index],
              index: index,
            ),
          ),
        );
      }),
    );
  }
}
