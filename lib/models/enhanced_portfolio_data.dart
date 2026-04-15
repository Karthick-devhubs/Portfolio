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
          'An AI-powered collaborative project management platform designed for healthcare students, educators, and manage projects, and enhance team productivity.',
      imageUrl: 'https://www.google.com/search?sca_esv=8503c9f894ce6c69&udm=2&fbs=ADc_l-aN0CWEZBOHjofHoaMMDiKpaEWjvZ2Py1XXV8d8KvlI3jljrY5CkLlk8Dq3IvwBz-Qg9gdZYJriKd9fBMKKfwqZlI558rPhYXCT0gQlVOCz7r3O6mKrYxvUenXFd2EC0wwnLCjCBZ14WQe_VshFqF7175h-ylteY_rsQ4jIXe_tYHrnRYlzpT2aAkY5i6iMjKnxs559BPtyCKmWIWAuuPanrgoSrA&q=dotzza&sa=X&ved=2ahUKEwi3kZz84u6TAxUBR2wGHRGbBFAQtKgLegQIHhAB&biw=1536&bih=730&dpr=1.25#sv=CAMSURoyKhBlLUVRSU5ialU1dzRucjNNMg5FUUlOYmpVNXc0bnIzTToOUmZwU2RESUJaRVJBeU0gBCoXCgFzEhBlLUVRSU5ialU1dzRucjNNGAEwARgHINKPq5wNSggQARgBIAEoAQ',
      features: [
        'AI-powered project collaboration tailored for healthcare workflows',
        'Teamspace creation for managing projects with structured roles',
        'Task management with Kanban boards and milestone tracking',
        'Built-in AI-driven OKR system to monitor project progress',
        'Centralized document and file management system',
        'Customizable workflows based on project type and requirements',
      ],
      techStack: ['Flutter', 'Firebase', 'GetX', 'REST API', 'AI Integration'],
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
        'Real-time financial tips and educational content',
        'User-friendly dashboard for tracking learning progress',
        'Secure authentication and personalized user profiles',
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
    'Automated winner selection and prize distribution logic',
    'Scalable architecture to handle multiple concurrent ticket rooms',
  ],
  techStack: [
    'Flutter',
    'GetX',
    'Firebase',
    'REST API',
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
  'Supports real-time tracking of match events such as Scrum, Lineout, Penalty, Knock-on, Restart, and Drop Goal attempts.',
'Provides a structured workflow that guides referees through correct game decisions based on match situations.',
'Includes an interactive rugby field interface where events are positioned accurately based on field location.',
'Ensures rule enforcement by validating actions according to rugby gameplay constraints (e.g., field boundaries, distances).',
'Enables smooth navigation between different match scenarios based on event outcomes.',
'Designed specifically for tablet usage, making it practical and easy to use during live matches.',
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
ProjectModel(
  id: 'proj_005',
  title: 'Clops Brand - Business & Brand Management App',
  description:
      'A mobile application designed to support business and brand management by providing secure access, streamlined workflows, and an improved user experience through modern interface enhancements.',
  imageUrl: 'https://images.unsplash.com/photo-1556740738-b6a63e27c4df?w=400&h=300&fit=crop',
  features: [
    'Business-focused platform for managing brand-related activities and user interactions',
    'Streamlined user onboarding and login experience for quick access to the platform',
    'Secure account access using Google Sign-In for simplified authentication',
    'Biometric authentication (fingerprint) for enhanced security and faster access',
    'Improved UI/UX to provide a clean and intuitive experience for business users',
    'Optimized navigation flow to ensure smooth access to key features and workflows',
    'Responsive and consistent design across multiple devices',
    'User-centric interface designed to improve productivity and ease of use',
  ],
  techStack: [
    'Flutter',
    'Firebase Authentication',
    'Google Sign-In',
    'Biometric Authentication',
    'REST API'
  ],
  githubUrl: '',
  liveUrl: 'https://play.google.com/store/apps/details?id=com.hypex.brand',
  createdAt: DateTime(2024, 6, 10),
  status: ProjectStatus.completed,
  likes: 198,
  views: 1560,
  category: 'Business / Productivity',
  tags: [
    'Business App',
    'Productivity',
    'Authentication',
    'Security',
    'Flutter',
    'Mobile App'
  ],
  screenshots: [
    'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=800&h=600&fit=crop',
    'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=800&h=600&fit=crop',
  ],
),
ProjectModel(
  id: 'proj_006',
  title: 'Wittehms - Dental Care Management App',
  description:
      'A dental care management application designed to streamline interactions between patients, dentists, and clinic staff by enabling efficient appointment scheduling and workflow management.',
  imageUrl: 'https://images.unsplash.com/photo-1588776814546-ec7e6c2b4bcb?w=400&h=300&fit=crop',
  features: [
    'Role-based system supporting patients, dentists, and clinic staff with tailored access',
    'Appointment booking and scheduling system for managing dental consultations',
    'Structured workflows to improve coordination between patients and dental professionals',
    'Centralized platform for handling patient interactions and clinic operations',
    'User-friendly interface designed for easy navigation and quick task completion',
    'Improved communication flow between patients and clinic staff',
    'Responsive design ensuring smooth experience across Android and iOS devices',
    'Optimized user experience to simplify appointment management and reduce manual effort',
  ],
  techStack: [
    'Flutter',
    'REST API',
    'Firebase',
    'GetX'
  ],
  githubUrl: '',
  liveUrl: '',
  createdAt: DateTime(2024, 5, 15),
  status: ProjectStatus.inProgress,
  likes: 164,
  views: 1290,
  category: 'Healthcare / Dental',
  tags: [
    'Healthcare',
    'Dental',
    'Appointment Booking',
    'Role-Based System',
    'Mobile App',
    'Productivity'
  ],
  screenshots: [
    'https://images.unsplash.com/photo-1588776814546-ec7e6c2b4bcb?w=800&h=600&fit=crop',
    'https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=800&h=600&fit=crop',
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
    const SkillCategory(category: 'Web Development', skills: ['HTML', 'CSS','Javascript']),
    const SkillCategory(category: 'Backend & APIs', skills: ['Java','Python', 'SpringBoot','Hibernate','JDBC', 'REST API',]),
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
