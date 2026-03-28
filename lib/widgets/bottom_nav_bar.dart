import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// Bottom navigation bar for mobile devices
class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onNavigate;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        border: Border(
          top: BorderSide(color: AppColors.primary.withOpacity(0.1)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
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
    final isActive = currentIndex == index;
    return InkWell(
      onTap: () => onNavigate(index),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? AppColors.secondary : AppColors.textMuted,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isActive ? AppColors.secondary : AppColors.textMuted,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
