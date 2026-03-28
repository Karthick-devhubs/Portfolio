import 'enhanced_models.dart';

/// Enhanced portfolio data with realistic production-level content
class EnhancedPortfolioData {
  static const String name = 'Karthick K';
  static const String title = 'Flutter Developer';
  static const String tagline =
      'Flutter Developer with hands-on experience building responsive, production-ready apps and continuously improving through real-world projects.';

  static const String about =
      'Flutter Developer with 1 year of experience in building high-performance, cross-platform mobile applications. Skilled in Flutter, Dart, with a strong focus on clean architecture, responsive UI, and smooth user experience. Experienced in API integration and developing scalable, reusable components. Passionate about creating modern, UI-rich applications and continuously learning backend technologies and AI-driven workflows to build smarter solutions.';

  static final List<ProjectModel> projects = [
    ProjectModel(
      id: 'proj_001',
      title: 'Dotzza - AI Healthcare Collaboration Platform',
      description:
          'An AI-powered collaborative project management platform designed for healthcare students, educators, and professionals to streamline workflows, manage projects, and enhance team productivity.',
      imageUrl: 'https://images.unsplash.com/photo-1581090700227-1e8b1c7bca4d?w=400&h=300&fit=crop',
      features: [
        'AI-powered project collaboration tailored for healthcare workflows',
        'Teamspace creation for managing projects with structured roles',
        'Task management with Kanban boards and milestone tracking',
        'Built-in AI-driven OKR system to monitor project progress',
        'Real-time collaboration with chat and contextual communication',
        'Centralized document and file management system',
        'Predefined templates for research, academic, and clinical projects',
        'Customizable workflows based on project type and requirements',
        'Resource planning and team role assignment features',
        'Outcome tracking and performance visualization dashboards',
        'Secure platform for managing sensitive healthcare-related data',
        'Supports healthcare education, research, and clinical teamwork',
      ],
      techStack: ['Flutter', 'Firebase', 'GetX', 'REST API', 'AI Integration', 'Cloud Storage'],
      githubUrl: 'https://github.com/karthick-dev/dotzza-clone',
      liveUrl: 'https://www.dotzza.com/',
      createdAt: DateTime(2024, 3, 10),
      status: ProjectStatus.completed,
      likes: 312,
      views: 2456,
      category: 'Healthcare / Productivity',
      tags: ['AI', 'Healthcare', 'Collaboration', 'Project Management', 'SaaS', 'Productivity'],
      screenshots: [
        'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&h=600&fit=crop',
        'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800&h=600&fit=crop',
      ],
    ),
    ProjectModel(
      id: 'proj_002',
      title: 'Finiclub - AI Financial Learning Platform',
      description:
          'An AI-powered financial literacy platform that helps users learn investing, budgeting, and personal finance through interactive courses, insights, and community-driven learning.',
      imageUrl: 'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=400&h=300&fit=crop',
      features: [
        'Interactive financial literacy courses for beginners and advanced users',
        'AI-powered insights for smarter financial decision making',
        'Learning modules covering investing, trading, and personal finance',
        'Progress tracking and personalized learning paths',
        'Community-driven discussions and knowledge sharing',
        'Real-time financial tips and educational content',
        'Gamified learning experience to improve engagement',
        'User-friendly dashboard for tracking learning progress',
        'Secure authentication and personalized user profiles',
        'Mobile-first responsive design for seamless access',
        'Content structured for practical, real-world financial application',
      ],
      techStack: ['Flutter', 'Firebase', 'GetX', 'REST API', 'AI Integration', 'Cloud Functions'],
      githubUrl: 'https://github.com/karthick-dev/finiclub-clone',
      liveUrl: 'https://finiclub.com/',
      createdAt: DateTime(2024, 4, 5),
      status: ProjectStatus.completed,
      likes: 287,
      views: 2134,
      category: 'Finance / EdTech',
      tags: ['FinTech', 'AI', 'Education', 'Mobile App', 'Learning Platform', 'Productivity'],
      screenshots: [
        'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800&h=600&fit=crop',
        'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&h=600&fit=crop',
      ],
    ),
    ProjectModel(
  id: 'proj_003',
  title: 'Lotto23 - Lottery Ticket Management Platform',
  description: 'A scalable lottery ticket selling and management application that enables admins, agents, and users to participate in a structured ticket distribution system with dynamic prize pools and commission-based earnings.',
  imageUrl: 'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=400&h=300&fit=crop',
  features: [
    'Role-based system with Admin, Agent, and User access control',
    'Admin panel for creating and managing lottery tickets',
    'Agent system to distribute tickets and earn commission on sales',
    'User interface for purchasing tickets and tracking participation',
    'Dynamic prize pool calculation based on tickets sold',
    'Global ticket system available for all users to participate',
    'Real-time ticket availability and countdown timers',
    'Commission tracking system for agents',
    'Secure transaction handling and purchase flow',
    'Interactive and gamified UI for enhanced user engagement',
    'Automated winner selection and prize distribution logic',
    'Scalable architecture to handle multiple concurrent ticket rooms',
  ],
  techStack: [
    'Flutter',
    'GetX',
    'Firebase',
    'REST API',
    'Realtime Database',
    'Cloud Functions',
  ],
  githubUrl: 'https://github.com/karthick-dev/lotto23-app',
  liveUrl: '',
  createdAt: DateTime(2024, 5, 12),
  status: ProjectStatus.inProgress,
  likes: 356,
  views: 2987,
  category: 'Gaming / FinTech',
  tags: [
    'Lottery',
    'Real-time',
    'Gamification',
    'Mobile App',
    'Business Logic',
    'Multi-role System',
  ],
  screenshots: [
    'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=800&h=600&fit=crop',
    'https://images.unsplash.com/photo-1518546305927-5a555bb7020d?w=800&h=600&fit=crop',
  ],
),
  
   ProjectModel(
  id: 'proj_004',
  title: 'RugbyManagement - Live Match & Management System',
  description: 'A real-time rugby match management and live score tracking system consisting of a tablet-based admin panel and a user-facing mobile app, enabling seamless match updates, rule enforcement, and live game insights.',
  imageUrl: 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=400&h=300&fit=crop',
  features: [
    'Dual-application system: Admin (tablet) + User (mobile) apps',
    'Real-time score updates synchronized across devices',
    'Complete rugby rule implementation including scrum, penalties, yellow/red cards',
    'Admin panel for match control, event updates, and player actions',
    'Live match dashboard for users with instant score visibility',
    'Event-based scoring system reflecting real match scenarios',
    'Team and player performance tracking',
    'Optimized UI for tablet-based match management',
    'Low-latency data updates for real-time experience',
    'Structured match flow based on official rugby rules',
    'Scalable architecture for managing multiple matches',
    'Clean and intuitive UI for both admin and user applications',
  ],
  techStack: [
    'Flutter',
    'GetX',
    'Firebase',
    'Realtime Database',
    'REST API',
  ],
  githubUrl: 'https://github.com/karthick-dev/rugby-management-app',
  liveUrl: '',
  createdAt: DateTime(2024, 6, 2),
  status: ProjectStatus.inProgress,
  likes: 298,
  views: 2210,
  category: 'Sports / Real-time',
  tags: [
    'Sports',
    'Real-time',
    'Live Score',
    'Multi-App System',
    'Rugby',
    'Admin Panel',
  ],
  screenshots: [
    'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800&h=600&fit=crop',
    'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?w=800&h=600&fit=crop',
  ],
),
  ];

  static final PortfolioAnalytics analytics = PortfolioAnalytics(
    totalViews: 10165,
    totalLikes: 1399,
    totalProjects: 6,
    viewsByProject: {'proj_005': 3102, 'proj_003': 2156, 'proj_001': 1847, 'proj_002': 1523, 'proj_006': 892, 'proj_004': 645},
    viewsByMonth: {'Jan': 1245, 'Feb': 1567, 'Mar': 1892, 'Apr': 2134, 'May': 1789, 'Jun': 1538},
    topTechnologies: ['Flutter', 'Firebase', 'Node.js', 'GetX', 'REST API', 'WebRTC', 'AI/ML'],
  );

  static final List<ContactMessage> messages = [
    ContactMessage(
      id: 'msg_001',
      name: 'Sarah Johnson',
      email: 'sarah.j@techcorp.com',
      subject: 'Freelance Project Inquiry',
      message:
          'Hi Karthick, I came across your portfolio and I\'m impressed with your work on the FinTrack app. We have a similar project and would like to discuss potential collaboration.',
      sentAt: DateTime(2024, 5, 15, 10, 30),
      status: MessageStatus.unread,
    ),
    ContactMessage(
      id: 'msg_002',
      name: 'Michael Chen',
      email: 'michael.chen@startup.io',
      subject: 'Job Opportunity - Senior Flutter Developer',
      message:
          'Hello, we\'re a fast-growing startup looking for a senior Flutter developer. Your experience with healthcare apps caught our attention. Are you open to discussing opportunities?',
      sentAt: DateTime(2024, 5, 14, 14, 20),
      status: MessageStatus.read,
    ),
  ];

  static final List<SkillCategory> enhancedSkills = [
    const SkillCategory(category: 'Mobile Development', skills: ['Flutter', 'Dart']),
    // const SkillCategory(
    //   category: 'State Management',
    //   skills: ['GetX', 'Provider', 'Riverpod', 'Bloc', 'Redux'],
    // ),
    const SkillCategory(category: 'Backend & APIs', skills: ['Java', 'Springs', 'REST API', 'GraphQL']),
    const SkillCategory(category: 'Databases', skills: ['Firebase', 'MySQL', 'SQL commands', 'Hive']),
    // const SkillCategory(
    //   category: 'Cloud & DevOps',
    //   skills: ['AWS', 'Google Cloud', 'Docker', 'CI/CD', 'Git'],
    // ),
    // const SkillCategory(
    //   category: 'AI & ML',
    //   skills: ['TensorFlow Lite', 'ML Kit', 'Computer Vision', 'NLP'],
    // ),
    // const SkillCategory(
    //   category: 'Real-time Features',
    //   skills: ['WebRTC', 'Socket.io', 'MQTT', 'Push Notifications'],
    // ),
    // const SkillCategory(
    //   category: 'Testing & Quality',
    //   skills: [
    //     'Unit Testing',
    //     'Widget Testing',
    //     'Integration Testing',
    //     'Test-Driven Development'
    //   ],
    // ),
  ];

  static const List<ExperienceModel> experience = [
    // ExperienceModel(
    //   role: 'Senior Flutter Developer',
    //   company: 'TechVision Solutions',
    //   duration: '2023 - Present',
    //   points: [
    //     'Led development of 3 production apps with 100K+ downloads',
    //     'Implemented CI/CD pipeline reducing deployment time by 60%',
    //     'Mentored 5 junior developers in Flutter best practices',
    //     'Architected scalable solutions using clean architecture',
    //   ],
    // ),
    ExperienceModel(
      role: 'Flutter Developer',
      company: 'Macincode Technologies',
      duration: '2025 - Present',
      points: [
        'Developed and maintained scalable cross-platform mobile applications using Flutter, ensuring high performance and responsiveness.',
        'Optimized application performance and reduced app size significantly through efficient state management and code refactoring.',
        'Integrated RESTful APIs and third-party services to enhance application functionality and user experience.',
        'Collaborated with cross-functional teams to deliver features on time and improve overall product quality.',
        'Designed reusable and modular UI components to improve maintainability and development speed.',
        'Handled bug fixing, performance tuning, and ensured smooth app releases on Play Store and App Store.',
      ],
    ),
  ];

  static const String email = 'karthiofficial0206@gmail.com';
  static const String linkedIn = 'https://www.linkedin.com/in/karthi2003/';
  static const String gitHub = 'https://github.com/Karthick-devhubs';
}
