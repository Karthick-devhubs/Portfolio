import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/enhanced_models.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../views/project_detail_page.dart';
import 'glassmorphism_container.dart';

/// A project card styled with Astra AI aesthetics and smooth hover transitions.
class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final int index;

  const ProjectCard({super.key, required this.project, required this.index});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _shimmerController;
  late Animation<double> _shimmer;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _shimmer = Tween<double>(begin: -1, end: 2).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _shimmerController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _shimmerController.reverse();
      },
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ProjectDetailPage(project: widget.project),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 0.96, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      ),
                    ),
                    child: child,
                  ),
                );
              },
              transitionDuration: const Duration(milliseconds: 350),
            ),
          );
        },
        child: AnimatedScale(
          scale: _isHovered ? 1.02 : 1.0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          child: AnimatedBuilder(
            animation: _shimmer,
            builder: (context, child) => Stack(
              children: [
                GlassmorphismContainer(
                  borderColor: _isHovered
                      ? AppColors.secondary.withValues(alpha: 0.6)
                      : AppColors.surfaceBorder,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with project index & status
                      Row(
                        children: [
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
                              style: AppTextStyles.chipText(context).copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor().withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: _getStatusColor().withValues(alpha: 0.4),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              widget.project.status.name.toUpperCase(),
                              style: TextStyle(
                                color: _getStatusColor(),
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Title
                      Text(
                        widget.project.title,
                        style: AppTextStyles.projectTitle(context),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      // Category
                      Text(
                        widget.project.category,
                        style: AppTextStyles.bodySmall(context).copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Description
                      Text(
                        widget.project.description,
                        style: AppTextStyles.body(context),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 16),

                      // Features summary
                      Row(
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            size: 16,
                            color: AppColors.primaryLight,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${widget.project.features.length} Key Features Included',
                              style: AppTextStyles.bodySmall(context).copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Action footer
                      Row(
                        children: [
                          const Icon(
                            Icons.touch_app_rounded,
                            size: 16,
                            color: AppColors.secondary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'View project details',
                            style: AppTextStyles.bodySmall(context).copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            size: 16,
                            color: AppColors.secondary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (_isHovered)
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CustomPaint(
                        painter: ShimmerPainter(_shimmer.value),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (widget.project.status) {
      case ProjectStatus.completed:
        return AppColors.success;
      case ProjectStatus.inProgress:
        return AppColors.accent;
      case ProjectStatus.archived:
        return AppColors.textMuted;
    }
  }
}

class ShimmerPainter extends CustomPainter {
  final double progress;

  ShimmerPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.transparent,
          AppColors.secondary.withValues(alpha: 0.12),
          Colors.transparent,
        ],
        stops: [progress - 0.25, progress, progress + 0.25],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(ShimmerPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
