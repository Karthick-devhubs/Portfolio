import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// Bottom navigation bar for mobile devices with modern animations
class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onNavigate;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onNavigate,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _previousIndex = widget.currentIndex;
  }

  @override
  void didUpdateWidget(BottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _previousIndex = oldWidget.currentIndex;
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.cardDark.withOpacity(0.95),
            AppColors.background,
          ],
        ),
        border: Border(
          top: BorderSide(color: AppColors.primary.withOpacity(0.2), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_rounded, 'Home', 0),
              _buildNavItem(Icons.work_rounded, 'Projects', 3),
              _buildNavItem(Icons.person_rounded, 'About', 1),
              _buildNavItem(Icons.mail_rounded, 'Contact', 5),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isActive = widget.currentIndex == index;
    return InkWell(
      onTap: () => widget.onNavigate(index),
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 20 : 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          gradient: isActive ? AppColors.primaryGradient : null,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: isActive ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              child: Icon(
                icon,
                color: isActive ? Colors.white : AppColors.textMuted,
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: isActive ? 12 : 11,
                color: isActive ? Colors.white : AppColors.textMuted,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
