import 'package:flutter/material.dart';
import '../models/enhanced_models.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../views/project_detail_page.dart';
import 'glassmorphism_container.dart';

/// A project card with glassmorphism styling and hover animation.
class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final int index;

  const ProjectCard({super.key, required this.project, required this.index});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectDetailPage(project: widget.project),
            ),
          );
        },
        child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.diagonal3Values(
          _isHovered ? 1.03 : 1.0,
          _isHovered ? 1.03 : 1.0,
          1.0,
        ),
        transformAlignment: Alignment.center,
        child: Stack(
          children: [
            GlassmorphismContainer(
          borderColor: _isHovered
              ? AppColors.secondary.withValues(alpha: 0.5)
              : AppColors.primary.withValues(alpha: 0.15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project number badge
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
                  '0${widget.index + 1}',
                  style: AppTextStyles.chipText(
                    context,
                  ).copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(height: 16),

              // Title
              Text(
                widget.project.title,
                style: AppTextStyles.projectTitle(context),
              ),
              const SizedBox(height: 8),

              // Description
              Text(
                widget.project.description,
                style: AppTextStyles.body(context),
              ),
              const SizedBox(height: 16),

              // Features
              ...widget.project.features.map(
                (f) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 10,
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(f, style: AppTextStyles.bodySmall(context)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Tech stack
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.project.techStack.map((tech) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      tech,
                      style: AppTextStyles.chipText(
                        context,
                      ).copyWith(fontSize: 11, color: AppColors.primary),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
            // View/Like indicators
            Positioned(
              top: 16,
              right: 16,
              child: Row(
                children: [
                  _buildMetric(Icons.visibility_rounded, widget.project.views),
                  const SizedBox(width: 12),
                  _buildMetric(Icons.favorite_rounded, widget.project.likes),
                ],
              ),
            ),
            // Status badge
            if (widget.project.status != ProjectStatus.completed)
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withOpacity(0.9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    widget.project.status.name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildMetric(IconData icon, int value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cardDark.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.secondary),
          const SizedBox(width: 4),
          Text(
            value > 999 ? '${(value / 1000).toStringAsFixed(1)}k' : value.toString(),
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (widget.project.status) {
      case ProjectStatus.completed:
        return Colors.green;
      case ProjectStatus.inProgress:
        return Colors.orange;
      case ProjectStatus.archived:
        return Colors.grey;
    }
  }
}
