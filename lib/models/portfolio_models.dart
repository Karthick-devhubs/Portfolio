/// Data model for a portfolio project.
class ProjectModel {
  final String title;
  final String description;
  final List<String> features;
  final List<String> techStack;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.features,
    required this.techStack,
  });
}

/// Data model for a skill category.
class SkillCategory {
  final String category;
  final List<String> skills;

  const SkillCategory({required this.category, required this.skills});
}

/// Data model for an experience entry.
class ExperienceModel {
  final String role;
  final String company;
  final String duration;
  final List<String> points;

  const ExperienceModel({
    required this.role,
    required this.company,
    required this.duration,
    required this.points,
  });
}
