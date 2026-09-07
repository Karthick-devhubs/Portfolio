import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// Pinned top-edge gradient progress bar indicating current page scroll depth.
class ScrollProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0

  const ScrollProgressBar({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress.clamp(0.0, 1.0);

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 3,
        width: double.infinity,
        color: Colors.transparent,
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: clampedProgress,
          child: Container(
            decoration: BoxDecoration(
              gradient: AppColors.cyberGradient,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryLight.withValues(alpha: 0.8),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: AppColors.accentCyan.withValues(alpha: 0.6),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
