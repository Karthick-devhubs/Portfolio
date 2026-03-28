import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

/// A styled skill chip with gradient border and hover effect.
class SkillChip extends StatefulWidget {
  final String label;

  const SkillChip({super.key, required this.label});

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.diagonal3Values(
          _isHovered ? 1.08 : 1.0,
          _isHovered ? 1.08 : 1.0,
          1.0,
        ),
        transformAlignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: _isHovered
              ? AppColors.primary.withValues(alpha: 0.15)
              : AppColors.cardDark.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? AppColors.secondary
                : AppColors.primary.withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.glowSecondary.withValues(alpha: 0.3),
                    blurRadius: 12,
                    spreadRadius: 0,
                  ),
                ]
              : [],
        ),
        child: Text(
          widget.label,
          style: AppTextStyles.chipText(context).copyWith(
            color: _isHovered ? AppColors.secondary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
