import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controls scroll position and section-based navigation.
class PortfolioController extends GetxController {
  final ScrollController scrollController = ScrollController();

  // Section keys for scroll-to navigation
  final heroKey = GlobalKey();
  final aboutKey = GlobalKey();
  final skillsKey = GlobalKey();
  final projectsKey = GlobalKey();
  final experienceKey = GlobalKey();
  final contactKey = GlobalKey();

  final currentSection = 0.obs;

  final List<String> navItems = [
    'Home',
    'About',
    'Skills',
    'Projects',
    'Experience',
    'Contact',
  ];

  /// Scroll to a section by index.
  void scrollToSection(int index) {
    currentSection.value = index;
    final key = _getKeyByIndex(index);
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  GlobalKey _getKeyByIndex(int index) {
    switch (index) {
      case 0:
        return heroKey;
      case 1:
        return aboutKey;
      case 2:
        return skillsKey;
      case 3:
        return projectsKey;
      case 4:
        return experienceKey;
      case 5:
        return contactKey;
      default:
        return heroKey;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
