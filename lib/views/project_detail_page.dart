import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/enhanced_models.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/responsive.dart';
import '../widgets/animated_button.dart';
import '../widgets/glassmorphism_container.dart';
import '../widgets/toast_service.dart';

/// Detailed project view page
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
                      // const SizedBox(height: 24),
                      // _buildStats(context),
                      const SizedBox(height: 32),
                      _buildDescription(context),
                      const SizedBox(height: 32),
                      _buildFeatures(context),
                      const SizedBox(height: 32),
                      _buildTechStack(context),
                      // if (project.screenshots.isNotEmpty) ...[
                      //   const SizedBox(height: 32),
                      //   _buildScreenshots(context),
                      // ],
                      // const SizedBox(height: 32),
                      // _buildActions(context),
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
      expandedHeight: 300,
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
                          AppColors.background.withOpacity(0.8),
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
          color: Colors.white.withOpacity(0.5),
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
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildStats(BuildContext context) {
    return GlassmorphismContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            context,
            Icons.visibility_rounded,
            project.views.toString(),
            'Views',
          ),
          Container(
            width: 1,
            height: 40,
            color: AppColors.primary.withOpacity(0.2),
          ),
          _buildStatItem(
            context,
            Icons.favorite_rounded,
            project.likes.toString(),
            'Likes',
          ),
          Container(
            width: 1,
            height: 40,
            color: AppColors.primary.withOpacity(0.2),
          ),
          _buildStatItem(
            context,
            Icons.code_rounded,
            project.techStack.length.toString(),
            'Technologies',
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    IconData icon,
    String value,
    String label,
  ) {
    return Column(
      children: [
        Icon(icon, color: AppColors.secondary, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTextStyles.subtitle(context).copyWith(fontSize: 20),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.bodySmall(context).copyWith(
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: AppTextStyles.subtitle(context),
        ),
        const SizedBox(height: 12),
        Text(
          project.description,
          style: AppTextStyles.body(context).copyWith(height: 1.8),
        ),
      ],
    );
  }

  Widget _buildFeatures(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Features',
          style: AppTextStyles.subtitle(context),
        ),
        const SizedBox(height: 16),
        ...project.features.map(
          (feature) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    size: 12,
                    color: AppColors.secondary,
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
    );
  }

  Widget _buildTechStack(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tech Stack',
          style: AppTextStyles.subtitle(context),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: project.techStack.map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                tech,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildScreenshots(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Screenshots',
          style: AppTextStyles.subtitle(context),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: project.screenshots.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    project.screenshots[index],
                    width: 300,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 300,
                      color: AppColors.surface,
                      child: const Icon(
                        Icons.image_not_supported_rounded,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        if (project.liveUrl != null)
          AnimatedGradientButton(
            text: 'View Live Demo',
            icon: Icons.launch_rounded,
            onPressed: () => _launchUrl(context, project.liveUrl!),
          ),
        if (project.githubUrl != null)
          AnimatedGradientButton(
            text: 'View on GitHub',
            icon: Icons.code_rounded,
            onPressed: () => _launchUrl(context, project.githubUrl!),
          ),
        AnimatedGradientButton(
          text: 'Share Project',
          icon: Icons.share_rounded,
          onPressed: () {
            ToastService.show(
              context,
              message: 'Share functionality coming soon!',
              type: ToastType.info,
            );
          },
        ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (project.status) {
      case ProjectStatus.completed:
        return Colors.green;
      case ProjectStatus.inProgress:
        return Colors.orange;
      case ProjectStatus.archived:
        return Colors.grey;
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
