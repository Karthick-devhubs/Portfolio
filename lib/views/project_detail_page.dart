import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/enhanced_models.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/responsive.dart';
import '../widgets/animated_button.dart';
import '../widgets/glassmorphism_container.dart';
import '../widgets/toast_service.dart';

/// Detailed project view page styled with Astra AI dark glassmorphism.
class ProjectDetailPage extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: Responsive.contentWidth(context),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context),
                      const SizedBox(height: 32),
                      _buildDescription(context),
                      const SizedBox(height: 32),
                      _buildFeatures(context),
                      const SizedBox(height: 32),
                      _buildTechStack(context),
                      const SizedBox(height: 32),
                      _buildActions(context),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: AppColors.cardDark,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: project.imageUrl != null
            ? Stack(
                fit: StackFit.expand,
                children: [
                  _buildImage(),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.background.withValues(alpha: 0.9),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : _buildPlaceholderImage(),
      ),
    );
  }

  Widget _buildImage() {
    final imageUrl = project.imageUrl!;
    return Image.asset(
      imageUrl,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => _buildPlaceholderImage(),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
      ),
      child: Center(
        child: Icon(
          Icons.code_rounded,
          size: 80,
          color: Colors.white.withValues(alpha: 0.5),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildBadge(
              project.status.name.toUpperCase(),
              _getStatusColor(),
            ),
            _buildBadge(
              project.category,
              AppColors.secondary,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          project.title,
          style: AppTextStyles.sectionTitle(context),
        ),
        const SizedBox(height: 8),
        Text(
          'Created ${_formatDate(project.createdAt)}',
          style: AppTextStyles.bodySmall(context).copyWith(
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return GlassmorphismContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About the Project',
            style: AppTextStyles.subtitle(context).copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            project.description,
            style: AppTextStyles.body(context).copyWith(height: 1.8),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatures(BuildContext context) {
    return GlassmorphismContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Key Features',
            style: AppTextStyles.subtitle(context).copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          ...project.features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      size: 14,
                      color: AppColors.primaryLight,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      feature,
                      style: AppTextStyles.body(context),
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

  Widget _buildTechStack(BuildContext context) {
    return GlassmorphismContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Technologies Used',
            style: AppTextStyles.subtitle(context).copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: project.techStack.map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tech,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    final hasLive = project.liveUrl != null && project.liveUrl!.isNotEmpty;
    final hasGithub = project.githubUrl != null && project.githubUrl!.isNotEmpty;

    if (!hasLive && !hasGithub) return const SizedBox.shrink();

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        if (hasLive)
          AnimatedGradientButton(
            text: 'View Live Demo',
            icon: Icons.launch_rounded,
            onPressed: () => _launchUrl(context, project.liveUrl!),
          ),
        if (hasGithub)
          AnimatedGradientButton(
            text: 'View on GitHub',
            icon: Icons.code_rounded,
            isSecondary: true,
            onPressed: () => _launchUrl(context, project.githubUrl!),
          ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (project.status) {
      case ProjectStatus.completed:
        return AppColors.success;
      case ProjectStatus.inProgress:
        return AppColors.accent;
      case ProjectStatus.archived:
        return AppColors.textMuted;
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  Future<void> _launchUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ToastService.show(
          context,
          message: 'Could not open URL',
          type: ToastType.error,
        );
      }
    }
  }
}
