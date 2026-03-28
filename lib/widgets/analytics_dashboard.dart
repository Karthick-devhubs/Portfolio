import 'package:flutter/material.dart';
import '../models/enhanced_models.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/responsive.dart';
import 'glassmorphism_container.dart';

/// Analytics dashboard showing portfolio statistics
class AnalyticsDashboard extends StatelessWidget {
  final PortfolioAnalytics analytics;

  const AnalyticsDashboard({super.key, required this.analytics});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Portfolio Analytics',
          style: AppTextStyles.sectionTitle(context),
        ),
        const SizedBox(height: 24),
        _buildStatsGrid(context, isMobile),
        const SizedBox(height: 24),
        _buildTopTechnologies(context),
      ],
    );
  }

  Widget _buildStatsGrid(BuildContext context, bool isMobile) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isMobile ? 2 : 4,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: isMobile ? 1.2 : 1.5,
      children: [
        _buildStatCard(
          context,
          Icons.visibility_rounded,
          analytics.totalViews.toString(),
          'Total Views',
          AppColors.primary,
        ),
        _buildStatCard(
          context,
          Icons.favorite_rounded,
          analytics.totalLikes.toString(),
          'Total Likes',
          Colors.red,
        ),
        _buildStatCard(
          context,
          Icons.work_rounded,
          analytics.totalProjects.toString(),
          'Projects',
          AppColors.secondary,
        ),
        _buildStatCard(
          context,
          Icons.code_rounded,
          analytics.topTechnologies.length.toString(),
          'Technologies',
          Colors.green,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return GlassmorphismContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: AppTextStyles.subtitle(context).copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.bodySmall(context).copyWith(
              color: AppColors.textMuted,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTopTechnologies(BuildContext context) {
    return GlassmorphismContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_up_rounded,
                color: AppColors.secondary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Top Technologies',
                style: AppTextStyles.subtitle(context).copyWith(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: analytics.topTechnologies.map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tech,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
