import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_colors.dart';

/// An interactive skill card with tech badge, glowing border, and hover spring scale.
class SkillChip extends StatefulWidget {
  final String label;
  final String? level;
  final IconData? icon;

  const SkillChip({
    super.key,
    required this.label,
    this.level,
    this.icon,
  });

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _pulseController;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
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

  IconData _getSkillIcon(String name) {
    if (widget.icon != null) return widget.icon!;
    final lower = name.toLowerCase();
    if (lower.contains('flutter')) return Icons.flutter_dash_rounded;
    if (lower.contains('dart')) return Icons.code_rounded;
    if (lower.contains('firebase')) return Icons.local_fire_department_rounded;
    if (lower.contains('api')) return Icons.cloud_sync_rounded;
    if (lower.contains('sql') || lower.contains('database')) return Icons.storage_rounded;
    if (lower.contains('java')) return Icons.coffee_rounded;
    if (lower.contains('python')) return Icons.terminal_rounded;
    if (lower.contains('spring')) return Icons.eco_rounded;
    if (lower.contains('html') || lower.contains('web')) return Icons.language_rounded;
    if (lower.contains('css')) return Icons.brush_rounded;
    if (lower.contains('javascript')) return Icons.javascript_rounded;
    if (lower.contains('hive')) return Icons.folder_zip_rounded;
    return Icons.check_circle_outline_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final skillIcon = _getSkillIcon(widget.label);

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
        onTap: () {
          HapticFeedback.selectionClick();
        },
        child: AnimatedBuilder(
          animation: _pulse,
          builder: (context, child) => Transform.scale(
            scale: _isHovered ? _pulse.value : 1.0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                gradient: _isHovered
                    ? LinearGradient(
                        colors: [
                          AppColors.primary.withValues(alpha: 0.25),
                          AppColors.secondary.withValues(alpha: 0.18),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: _isHovered ? null : AppColors.cardDark,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: _isHovered
                      ? AppColors.secondary
                      : AppColors.surfaceBorder,
                  width: _isHovered ? 1.5 : 1.2,
                ),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: AppColors.secondary.withValues(alpha: 0.35),
                          blurRadius: 18,
                          spreadRadius: 1,
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    skillIcon,
                    size: 18,
                    color: _isHovered
                        ? AppColors.accentCyan
                        : AppColors.primaryLight,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.label,
                    style: TextStyle(
                      color: _isHovered ? Colors.white : AppColors.textSecondary,
                      fontSize: 14,
                      fontWeight:
                          _isHovered ? FontWeight.w700 : FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}