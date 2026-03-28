/// Enhanced data model for a portfolio project with production-level fields
class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final List<String> features;
  final List<String> techStack;
  final String? githubUrl;
  final String? liveUrl;
  final DateTime createdAt;
  final ProjectStatus status;
  final int likes;
  final int views;
  final List<String> screenshots;
  final String category;
  final List<String> tags;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.features,
    required this.techStack,
    this.githubUrl,
    this.liveUrl,
    required this.createdAt,
    this.status = ProjectStatus.completed,
    this.likes = 0,
    this.views = 0,
    this.screenshots = const [],
    required this.category,
    this.tags = const [],
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
        'features': features,
        'techStack': techStack,
        'githubUrl': githubUrl,
        'liveUrl': liveUrl,
        'createdAt': createdAt.toIso8601String(),
        'status': status.name,
        'likes': likes,
        'views': views,
        'screenshots': screenshots,
        'category': category,
        'tags': tags,
      };

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        imageUrl: json['imageUrl'],
        features: List<String>.from(json['features']),
        techStack: List<String>.from(json['techStack']),
        githubUrl: json['githubUrl'],
        liveUrl: json['liveUrl'],
        createdAt: DateTime.parse(json['createdAt']),
        status: ProjectStatus.values.byName(json['status']),
        likes: json['likes'] ?? 0,
        views: json['views'] ?? 0,
        screenshots: List<String>.from(json['screenshots'] ?? []),
        category: json['category'],
        tags: List<String>.from(json['tags'] ?? []),
      );
}

enum ProjectStatus { inProgress, completed, archived }

/// Data model for a skill category
class SkillCategory {
  final String category;
  final List<String> skills;

  const SkillCategory({required this.category, required this.skills});
}

/// Data model for an experience entry
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

/// Analytics Model for portfolio insights
class PortfolioAnalytics {
  final int totalViews;
  final int totalLikes;
  final int totalProjects;
  final Map<String, int> viewsByProject;
  final Map<String, int> viewsByMonth;
  final List<String> topTechnologies;

  const PortfolioAnalytics({
    required this.totalViews,
    required this.totalLikes,
    required this.totalProjects,
    required this.viewsByProject,
    required this.viewsByMonth,
    required this.topTechnologies,
  });
}

/// Contact Form Model
class ContactMessage {
  final String id;
  final String name;
  final String email;
  final String subject;
  final String message;
  final DateTime sentAt;
  final MessageStatus status;

  const ContactMessage({
    required this.id,
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
    required this.sentAt,
    this.status = MessageStatus.unread,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'subject': subject,
        'message': message,
        'sentAt': sentAt.toIso8601String(),
        'status': status.name,
      };

  factory ContactMessage.fromJson(Map<String, dynamic> json) => ContactMessage(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        subject: json['subject'],
        message: json['message'],
        sentAt: DateTime.parse(json['sentAt']),
        status: MessageStatus.values.byName(json['status']),
      );
}

enum MessageStatus { unread, read, replied, archived }
