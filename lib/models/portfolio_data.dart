import '../models/portfolio_models.dart';

/// All portfolio content data in one place.
class PortfolioData {
  static const String name = 'Karthick';
  static const String title = 'Flutter Developer';
  static const String tagline =
      'Building scalable, high-performance mobile apps with stunning UI';

  static const String about =
      'Passionate Flutter developer with experience in building cross-platform '
      'applications. Focused on clean architecture, performance optimization, '
      'and engaging user interfaces. Exploring AI workflows and automation to '
      'build next-gen applications.';

  static const List<SkillCategory> skills = [
    SkillCategory(category: 'Frontend', skills: ['Flutter', 'Dart']),
    SkillCategory(category: 'Backend', skills: ['Node.js', 'Express']),
    SkillCategory(category: 'State Management', skills: ['GetX']),
    SkillCategory(category: 'Tools', skills: ['Git', 'Firebase', 'REST APIs']),
    SkillCategory(category: 'Others', skills: ['AI Workflows', 'Automation']),
  ];

  static const List<ProjectModel> projects = [
    ProjectModel(
      title: 'Smart Jackpot App',
      description:
          'A gamified lottery-style mobile app with dynamic ticket system',
      features: [
        'Live countdown timer',
        'Dynamic ticket availability',
        'Reward-based UI system',
        'Real-time updates',
      ],
      techStack: ['Flutter', 'GetX', 'Firebase'],
    ),
    ProjectModel(
      title: 'Task Manager Pro',
      description: 'Productivity app with task tracking and reminders',
      features: [
        'CRUD operations',
        'Clean UI with animations',
        'API integration ready',
      ],
      techStack: ['Flutter', 'REST API', 'GetX'],
    ),
    ProjectModel(
      title: 'E-Commerce UI Kit',
      description: 'Modern UI kit for shopping apps',
      features: ['Responsive design', 'Product listing UI', 'Cart system UI'],
      techStack: ['Flutter'],
    ),
  ];

  static const List<ExperienceModel> experience = [
    ExperienceModel(
      role: 'Flutter Developer',
      company: 'XYZ Company',
      duration: '2024 - Present',
      points: [
        'Developed scalable mobile applications using Flutter',
        'Implemented GetX for efficient state management',
        'Built reusable UI components',
        'Integrated REST APIs and improved app performance',
      ],
    ),
  ];

  static const String email = 'karthick.dev@gmail.com';
  static const String linkedIn = 'https://linkedin.com/in/karthick';
  static const String gitHub = 'https://github.com/karthick-dev';
}
