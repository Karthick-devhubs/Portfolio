import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

/// A styled skill chip with Astra AI glow and hover effects.
class SkillChip extends StatefulWidget {
  final String label;

  const SkillChip({super.key, required this.label});

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isTapped = false;
  late AnimationController _pulseController;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _pulse = Tween<double>(begin: 1.0, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isActive = _isHovered || _isTapped;

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _pulseController.repeat(reverse: true);
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _pulseController.stop();
        _pulseController.reset();
      },
      child: GestureDetector(
        onTapDown: (_) {
          HapticFeedback.selectionClick();
          setState(() => _isTapped = true);
        },
        onTapUp: (_) {
          Future.delayed(const Duration(milliseconds: 150), () {
            if (mounted) setState(() => _isTapped = false);
          });
        },
        onTapCancel: () => setState(() => _isTapped = false),
        child: AnimatedBuilder(
          animation: _pulse,
          builder: (context, child) => Transform.scale(
            scale: _isTapped ? 0.95 : (isActive ? _pulse.value : 1.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: isActive
                    ? LinearGradient(
                        colors: [
                          AppColors.primary.withValues(alpha: 0.2),
                          AppColors.secondary.withValues(alpha: 0.15),
                        ],
                      )
                    : null,
                color: isActive ? null : AppColors.cardDark,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isActive
                      ? AppColors.secondary
                      : AppColors.surfaceBorder,
                  width: 1.2,
                ),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: AppColors.glowSecondary.withValues(alpha: 0.35),
                          blurRadius: 16,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
              ),
              child: Text(
                widget.label,
                style: AppTextStyles.chipText(context).copyWith(
                  color: isActive ? Colors.white : AppColors.textSecondary,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}