import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/responsive.dart';

/// A reusable wrapper for each portfolio section with Astra AI styled headers and padding.
class SectionContainer extends StatelessWidget {
  final GlobalKey sectionKey;
  final String title;
  final Widget child;
  final bool showTitle;

  const SectionContainer({
    super.key,
    required this.sectionKey,
    required this.title,
    required this.child,
    this.showTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: Responsive.isMobile(context) ? 48 : 72,
      ),
      child: Center(
        child: SizedBox(
          width: Responsive.contentWidth(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showTitle) ...[
                _SectionTitle(title: title),
                const SizedBox(height: 36),
              ],
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.heroGradient.createShader(bounds),
          child: Text(
            title,
            style: AppTextStyles.sectionTitle(context).copyWith(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 50,
          height: 3.5,
          decoration: BoxDecoration(
            gradient: AppColors.heroGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}
