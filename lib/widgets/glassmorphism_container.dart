import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// A glassmorphic card container with blur, border, and subtle glow.
class GlassmorphismContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double blur;
  final Color? borderColor;

  const GlassmorphismContainer({
    super.key,
    required this.child,
    this.borderRadius = 20,
    this.padding = const EdgeInsets.all(24),
    this.blur = 10,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: AppColors.cardDark.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor ?? AppColors.primary.withValues(alpha: 0.15),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.glowPrimary.withValues(alpha: 0.08),
                blurRadius: 24,
                spreadRadius: 0,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
