import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/portfolio_controller.dart';
import '../../models/enhanced_portfolio_data.dart';
import '../../utils/responsive.dart';
import '../../widgets/animated_on_scroll.dart';
import '../../widgets/project_card.dart';
import '../../widgets/section_container.dart';

/// Projects section with responsive grid of project cards styled after Astra AI.
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
      title: 'Featured Projects',
      child: _buildCards(context, crossAxisCount, availableWidth),
    );
  }

  Widget _buildCards(
    BuildContext context,
    int crossAxisCount,
    double availableWidth,
  ) {
    if (crossAxisCount == 1) {
      // Enhanced mobile card layout with stagger animation
      return Column(
        children: List.generate(EnhancedPortfolioData.projects.length, (index) {
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 350 + (index * 80)),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(20 * (1 - value), 0),
                child: Opacity(
                  opacity: value,
                  child: child,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
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
    const spacing = 24.0;
    final cardWidth =
        (availableWidth - (crossAxisCount - 1) * spacing) / crossAxisCount;

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: List.generate(EnhancedPortfolioData.projects.length, (index) {
        return AnimatedOnScroll(
          delay: Duration(milliseconds: index * 120),
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
