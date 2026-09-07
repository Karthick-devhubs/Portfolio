import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

/// Astra AI styled animated button with radiant glow and smooth interaction.
class AnimatedGradientButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final double? width;
  final bool isSecondary;

  const AnimatedGradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.width,
    this.isSecondary = false,
  });

  @override
  State<AnimatedGradientButton> createState() => _AnimatedGradientButtonState();
}

class _AnimatedGradientButtonState extends State<AnimatedGradientButton>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isPressed = false;
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2400),
      vsync: this,
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.25, end: 0.55).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedBuilder(
          animation: _glowAnimation,
          builder: (context, child) {
            return AnimatedScale(
              scale: _isPressed ? 0.96 : (_isHovered ? 1.03 : 1.0),
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeOutCubic,
              child: Container(
                width: widget.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: widget.isSecondary
                      ? null
                      : AppColors.primaryGradient,
                  color: widget.isSecondary ? AppColors.surface : null,
                  border: Border.all(
                    color: widget.isSecondary
                        ? (_isHovered ? AppColors.secondary : AppColors.surfaceBorder)
                        : Colors.transparent,
                    width: 1.5,
                  ),
                  boxShadow: widget.isSecondary
                      ? []
                      : [
                          BoxShadow(
                            color: AppColors.primary.withValues(
                              alpha: _glowAnimation.value,
                            ),
                            blurRadius: _isHovered ? 28 : 18,
                            spreadRadius: _isHovered ? 2 : 0,
                          ),
                        ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: widget.onPressed,
                    splashColor: Colors.white.withValues(alpha: 0.2),
                    highlightColor: Colors.white.withValues(alpha: 0.1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 16,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.icon != null) ...[
                            Icon(
                              widget.icon,
                              color: Colors.white,
                              size: 18,
                            ),
                            const SizedBox(width: 10),
                          ],
                          Text(
                            widget.text,
                            style: AppTextStyles.buttonText(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
