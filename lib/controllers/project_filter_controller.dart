import 'package:get/get.dart';
import '../models/enhanced_models.dart';
import '../models/enhanced_portfolio_data.dart';

/// Controller for filtering and managing projects
class ProjectFilterController extends GetxController {
  final allProjects = EnhancedPortfolioData.projects;
  final filteredProjects = <ProjectModel>[].obs;
  final selectedCategory = 'All'.obs;
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    filteredProjects.value = allProjects;
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
    _applyFilters();
  }

  void searchProjects(String query) {
    searchQuery.value = query.toLowerCase();
    _applyFilters();
  }

  void _applyFilters() {
    var projects = allProjects;

    // Filter by category
    if (selectedCategory.value != 'All') {
      projects = projects
          .where((p) => p.category == selectedCategory.value)
          .toList();
    }

    // Filter by search query
    if (searchQuery.value.isNotEmpty) {
      projects = projects.where((p) {
        return p.title.toLowerCase().contains(searchQuery.value) ||
            p.description.toLowerCase().contains(searchQuery.value) ||
            p.techStack.any((tech) =>
                tech.toLowerCase().contains(searchQuery.value));
      }).toList();
    }

    filteredProjects.value = projects;
  }

  List<String> get categories {
    final cats = allProjects.map((p) => p.category).toSet().toList();
    cats.insert(0, 'All');
    return cats;
  }
}
