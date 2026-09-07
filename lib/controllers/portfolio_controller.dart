import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controls scroll position, dynamic scroll progress, and section-based auto-detection.
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
  final scrollProgress = 0.0.obs;
  final showBackToTop = false.obs;

  // Project Category Filter
  final selectedProjectCategory = 'All'.obs;
  final projectSearchQuery = ''.obs;

  // Skills Category Filter
  final selectedSkillCategory = 'All'.obs;
  final skillSearchQuery = ''.obs;

  final List<String> navItems = [
    'Home',
    'About',
    'Skills',
    'Projects',
    'Experience',
    'Contact',
  ];

  bool _isManualScrolling = false;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentOffset = scrollController.offset;

    // Calculate normalized progress (0.0 to 1.0)
    if (maxScroll > 0) {
      scrollProgress.value = (currentOffset / maxScroll).clamp(0.0, 1.0);
    }

    // Toggle Back To Top visibility
    showBackToTop.value = currentOffset > 350;

    // Auto-detect current active section if not manually animating
    if (!_isManualScrolling) {
      _detectCurrentSection();
    }
  }

  void _detectCurrentSection() {
    final keys = [
      heroKey,
      aboutKey,
      skillsKey,
      projectsKey,
      experienceKey,
      contactKey,
    ];

    int detected = 0;
    for (int i = 0; i < keys.length; i++) {
      final context = keys[i].currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null && box.hasSize) {
          final position = box.localToGlobal(Offset.zero);
          // If the section top is above 40% of the screen height, it is active
          if (position.dy <= 300) {
            detected = i;
          }
        }
      }
    }

    if (currentSection.value != detected) {
      currentSection.value = detected;
    }
  }

  /// Scroll to a section by index.
  void scrollToSection(int index) {
    currentSection.value = index;
    final key = _getKeyByIndex(index);
    final context = key.currentContext;

    if (context != null) {
      _isManualScrolling = true;
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      ).then((_) {
        Future.delayed(const Duration(milliseconds: 100), () {
          _isManualScrolling = false;
        });
      });
    }
  }

  /// Smooth scroll to very top
  void scrollToTop() {
    _isManualScrolling = true;
    currentSection.value = 0;
    scrollController
        .animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    )
        .then((_) {
      _isManualScrolling = false;
    });
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
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }
}
