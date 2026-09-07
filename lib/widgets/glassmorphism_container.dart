import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// An ultra-premium glassmorphic card container with backdrop blur,
/// glowing specular gradient borders, and smooth hover responsiveness.
class GlassmorphismContainer extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double blur;
  final Color? borderColor;
  final Gradient? borderGradient;
  final Color? backgroundColor;
  final bool enableHoverGlow;
  final VoidCallback? onTap;

  const GlassmorphismContainer({
    super.key,
    required this.child,
    this.borderRadius = 16,
    this.padding = const EdgeInsets.all(24),
    this.blur = 14,
    this.borderColor,
    this.borderGradient,
    this.backgroundColor,
    this.enableHoverGlow = false,
    this.onTap,
  });

  @override
  State<GlassmorphismContainer> createState() => _GlassmorphismContainerState();
}

class _GlassmorphismContainerState extends State<GlassmorphismContainer> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final activeBorderColor = widget.borderColor ??
        (_isHovered
            ? AppColors.secondary.withValues(alpha: 0.6)
            : AppColors.surfaceBorder);

    final bg = widget.backgroundColor ??
        (_isHovered
            ? AppColors.cardElevated.withValues(alpha: 0.88)
            : AppColors.cardDark.withValues(alpha: 0.82));

    return MouseRegion(
      onEnter: widget.enableHoverGlow
          ? (_) => setState(() => _isHovered = true)
          : null,
      onExit: widget.enableHoverGlow
          ? (_) => setState(() => _isHovered = false)
          : null,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
              if (_isHovered && widget.enableHoverGlow)
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  blurRadius: 28,
                  spreadRadius: 1,
                ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: widget.blur,
                sigmaY: widget.blur,
              ),
              child: Container(
                padding: widget.padding,
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  border: Border.all(
                    color: activeBorderColor,
                    width: _isHovered && widget.enableHoverGlow ? 1.5 : 1.2,
                  ),
                ),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
