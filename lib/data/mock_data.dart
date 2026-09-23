// ============================================================
// MOCK DATA — API response structurasiga mos
// TODO: Keyinchalik BLoC + Dio bilan real API'dan almashtiriladi
// ============================================================

// ─── CATEGORY ───────────────────────────────────────────────
class CategoryModel {
  final int id;
  final String name;
  final String icon;
  final int courseCount;
  final String color;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.courseCount,
    required this.color,
  });
}

// ─── TEACHER ────────────────────────────────────────────────
class TeacherModel {
  final int id;
  final String name;
  final String avatar;
  final String title;
  final double rating;
  final int studentsCount;
  final int coursesCount;

  const TeacherModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.title,
    required this.rating,
    required this.studentsCount,
    required this.coursesCount,
  });
}

// ─── COURSE ─────────────────────────────────────────────────
class CourseModel {
  final int id;
  final String title;
  final String description;
  final String image;
  final String category;
  final int categoryId;
  final TeacherModel teacher;
  final double price;
  final double? discountPrice;
  final double rating;
  final int studentsCount;
  final String level;
  final String duration;
  final int lessonsCount;
  final bool isFavorite;
  final List<String> whatYouLearn;
  final List<String> requirements;
  final List<ModuleModel> curriculum;

  const CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.category,
    required this.categoryId,
    required this.teacher,
    required this.price,
    this.discountPrice,
    required this.rating,
    required this.studentsCount,
    required this.level,
    required this.duration,
    required this.lessonsCount,
    this.isFavorite = false,
    this.whatYouLearn = const [],
    this.requirements = const [],
    this.curriculum = const [],
  });

  bool get hasDiscount => discountPrice != null && discountPrice! < price;

  int get discountPercent =>
      hasDiscount ? ((price - discountPrice!) / price * 100).round() : 0;
}

// ─── MODULE ─────────────────────────────────────────────────
class ModuleModel {
  final int id;
  final String title;
  final List<LessonModel> lessons;

  const ModuleModel({
    required this.id,
    required this.title,
    required this.lessons,
  });
}

// ─── LESSON ─────────────────────────────────────────────────
class LessonModel {
  final int id;
  final String title;
  final String duration;
  final String? videoUrl;
  final String? description;
  final bool isLocked;
  final bool isCompleted;
  final List<AttachmentModel> attachments;

  const LessonModel({
    required this.id,
    required this.title,
    required this.duration,
    this.videoUrl,
    this.description,
    this.isLocked = false,
    this.isCompleted = false,
    this.attachments = const [],
  });
}

// ─── ATTACHMENT ─────────────────────────────────────────────
class AttachmentModel {
  final int id;
  final String title;
  final String fileType;
  final String fileSize;

  const AttachmentModel({
    required this.id,
    required this.title,
    required this.fileType,
    required this.fileSize,
  });
}

// ─── ENROLLMENT ─────────────────────────────────────────────
class EnrollmentModel {
  final int id;
  final CourseModel course;
  final double progress;
  final int completedLessons;
  final int totalLessons;
  final String currentLesson;
  final bool isCompleted;
  final String enrolledAt;

  const EnrollmentModel({
    required this.id,
    required this.course,
    required this.progress,
    required this.completedLessons,
    required this.totalLessons,
    required this.currentLesson,
    required this.isCompleted,
    required this.enrolledAt,
  });
}

// ─── TEST ────────────────────────────────────────────────────
class TestModel {
  final int id;
  final String title;
  final int duration;
  final int totalQuestions;
  final List<QuestionModel> questions;

  const TestModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.totalQuestions,
    required this.questions,
  });
}

// ─── QUESTION ────────────────────────────────────────────────
class QuestionModel {
  final int id;
  final String text;
  final List<AnswerModel> answers;

  const QuestionModel({
    required this.id,
    required this.text,
    required this.answers,
  });
}

// ─── ANSWER ─────────────────────────────────────────────────
class AnswerModel {
  final int id;
  final String text;
  final bool isCorrect;

  const AnswerModel({
    required this.id,
    required this.text,
    required this.isCorrect,
  });
}

// ─── RESULT ─────────────────────────────────────────────────
class ResultModel {
  final int id;
  final int testId;
  final String testTitle;
  final int score;
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final double percentage;
  final bool isPassed;
  final String completedAt;

  const ResultModel({
    required this.id,
    required this.testId,
    required this.testTitle,
    required this.score,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.percentage,
    required this.isPassed,
    required this.completedAt,
  });
}

// ─── CERTIFICATE ─────────────────────────────────────────────
class CertificateModel {
  final int id;
  final String courseTitle;
  final String completionDate;
  final String certificateUrl;

  const CertificateModel({
    required this.id,
    required this.courseTitle,
    required this.completionDate,
    required this.certificateUrl,
  });
}

// ─── REVIEW ──────────────────────────────────────────────────
class ReviewModel {
  final int id;
  final String userName;
  final String userAvatar;
  final double rating;
  final String comment;
  final String createdAt;

  const ReviewModel({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });
}

// ─── NOTIFICATION ────────────────────────────────────────────
class NotificationModel {
  final int id;
  final String title;
  final String message;
  final String type;
  final bool isRead;
  final String createdAt;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    required this.createdAt,
  });
}

// ─── USER ────────────────────────────────────────────────────
class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? avatar;
  final String role;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.avatar,
    required this.role,
  });
}

// ============================================================
// MOCK DATA VALUES
// ============================================================

final mockUser = const UserModel(
  id: 1,
  name: 'Jasur Toshmatov',
  email: 'jasur@example.com',
  phone: '+998901234567',
  avatar: null,
  role: 'student',
);

final mockTeachers = [
  const TeacherModel(
    id: 1,
    name: 'Abdulloh Yusupov',
    avatar: '',
    title: 'Senior Flutter Developer',
    rating: 4.9,
    studentsCount: 12400,
    coursesCount: 8,
  ),
  const TeacherModel(
    id: 2,
    name: 'Nilufar Rahimova',
    avatar: '',
    title: 'UI/UX Designer & Figma Expert',
    rating: 4.8,
    studentsCount: 8700,
    coursesCount: 5,
  ),
  const TeacherModel(
    id: 3,
    name: 'Bobur Xasanov',
    avatar: '',
    title: 'Python & AI Engineer',
    rating: 4.7,
    studentsCount: 9300,
    coursesCount: 6,
  ),
  const TeacherModel(
    id: 4,
    name: 'Zulfiya Mirzayeva',
    avatar: '',
    title: 'Digital Marketing Expert',
    rating: 4.6,
    studentsCount: 5200,
    coursesCount: 4,
  ),
];

final mockCategories = [
  const CategoryModel(
    id: 1,
    name: 'Programming',
    icon: '💻',
    courseCount: 48,
    color: '4F46E5',
  ),
  const CategoryModel(
    id: 2,
    name: 'Design',
    icon: '🎨',
    courseCount: 32,
    color: 'EC4899',
  ),
  const CategoryModel(
    id: 3,
    name: 'Business',
    icon: '📊',
    courseCount: 27,
    color: 'F59E0B',
  ),
  const CategoryModel(
    id: 4,
    name: 'English',
    icon: '🌍',
    courseCount: 19,
    color: '10B981',
  ),
  const CategoryModel(
    id: 5,
    name: 'Mathematics',
    icon: '📐',
    courseCount: 21,
    color: '06B6D4',
  ),
  const CategoryModel(
    id: 6,
    name: 'Marketing',
    icon: '📣',
    courseCount: 15,
    color: 'EF4444',
  ),
];

final mockLessons = [
  const LessonModel(
    id: 1,
    title: 'Introduction to Flutter',
    duration: '12:30',
    isLocked: false,
    isCompleted: true,
    description:
        'In this lesson, we will explore the basics of Flutter framework and understand how it works.',
    attachments: [
      AttachmentModel(
        id: 1,
        title: 'Flutter Basics PDF',
        fileType: 'PDF',
        fileSize: '2.4 MB',
      ),
      AttachmentModel(
        id: 2,
        title: 'Starter Code',
        fileType: 'ZIP',
        fileSize: '1.1 MB',
      ),
    ],
  ),
  const LessonModel(
    id: 2,
    title: 'Widgets & Layout',
    duration: '18:45',
    isLocked: false,
    isCompleted: true,
    description: 'Deep dive into Flutter widgets and how to build layouts.',
  ),
  const LessonModel(
    id: 3,
    title: 'State Management Basics',
    duration: '22:10',
    isLocked: false,
    isCompleted: false,
    description: 'Learn how to manage state in Flutter applications.',
  ),
  const LessonModel(
    id: 4,
    title: 'Navigation & Routing',
    duration: '15:20',
    isLocked: true,
    isCompleted: false,
  ),
  const LessonModel(
    id: 5,
    title: 'API Integration with Dio',
    duration: '28:00',
    isLocked: true,
    isCompleted: false,
  ),
];

final mockModules = [
  ModuleModel(
    id: 1,
    title: 'Module 1: Getting Started',
    lessons: mockLessons.sublist(0, 3),
  ),
  ModuleModel(
    id: 2,
    title: 'Module 2: Intermediate Concepts',
    lessons: mockLessons.sublist(3),
  ),
];

final mockCourses = [
  CourseModel(
    id: 1,
    title: 'Flutter Developer Bootcamp 2024',
    description:
        'Become a professional Flutter developer from scratch. This comprehensive course covers everything from basics to advanced topics including state management, API integration, and deployment.',
    image: '',
    category: 'Programming',
    categoryId: 1,
    teacher: mockTeachers[0],
    price: 299000,
    discountPrice: 149000,
    rating: 4.9,
    studentsCount: 3420,
    level: 'Beginner',
    duration: '42h 30m',
    lessonsCount: 124,
    isFavorite: true,
    whatYouLearn: [
      'Build beautiful Flutter UIs from scratch',
      'Master state management with BLoC',
      'Integrate REST APIs using Dio',
      'Publish apps to Play Store & App Store',
      'Write clean, production-quality code',
    ],
    requirements: [
      'Basic programming knowledge',
      'A computer with internet access',
      'Motivation to learn Flutter',
    ],
    curriculum: mockModules,
  ),
  CourseModel(
    id: 2,
    title: 'UI/UX Design with Figma — Pro',
    description:
        'Master Figma and design stunning mobile and web interfaces like a professional designer.',
    image: '',
    category: 'Design',
    categoryId: 2,
    teacher: mockTeachers[1],
    price: 199000,
    discountPrice: 99000,
    rating: 4.8,
    studentsCount: 2180,
    level: 'Intermediate',
    duration: '28h 15m',
    lessonsCount: 87,
    isFavorite: false,
    whatYouLearn: [
      'Master Figma from beginner to pro',
      'Design mobile and web UI',
      'Create design systems and components',
      'Prototype interactive designs',
    ],
    requirements: ['No prior design experience needed', 'Figma account (free)'],
    curriculum: mockModules,
  ),
  CourseModel(
    id: 3,
    title: 'Python & Machine Learning A-Z',
    description:
        'Comprehensive Python and ML course covering data science, neural networks, and AI development.',
    image: '',
    category: 'Programming',
    categoryId: 1,
    teacher: mockTeachers[2],
    price: 349000,
    rating: 4.7,
    studentsCount: 4100,
    level: 'Intermediate',
    duration: '56h 00m',
    lessonsCount: 156,
    isFavorite: true,
    curriculum: mockModules,
  ),
  CourseModel(
    id: 4,
    title: 'Digital Marketing Masterclass',
    description:
        'Learn everything about digital marketing, SEO, social media, and online advertising.',
    image: '',
    category: 'Marketing',
    categoryId: 6,
    teacher: mockTeachers[3],
    price: 179000,
    discountPrice: 89000,
    rating: 4.6,
    studentsCount: 1850,
    level: 'Beginner',
    duration: '22h 45m',
    lessonsCount: 68,
    isFavorite: false,
    curriculum: mockModules,
  ),
  CourseModel(
    id: 5,
    title: 'Business English for Professionals',
    description:
        'Improve your professional English communication skills for career growth.',
    image: '',
    category: 'English',
    categoryId: 4,
    teacher: mockTeachers[1],
    price: 149000,
    rating: 4.8,
    studentsCount: 2900,
    level: 'Intermediate',
    duration: '18h 30m',
    lessonsCount: 54,
    isFavorite: false,
    curriculum: mockModules,
  ),
  CourseModel(
    id: 6,
    title: 'React & Next.js — Full Stack',
    description:
        'Build modern web applications with React and Next.js framework.',
    image: '',
    category: 'Programming',
    categoryId: 1,
    teacher: mockTeachers[0],
    price: 279000,
    discountPrice: 139000,
    rating: 4.7,
    studentsCount: 3150,
    level: 'Advanced',
    duration: '48h 20m',
    lessonsCount: 142,
    isFavorite: true,
    curriculum: mockModules,
  ),
];

final mockEnrollments = [
  EnrollmentModel(
    id: 1,
    course: mockCourses[0],
    progress: 0.65,
    completedLessons: 18,
    totalLessons: 28,
    currentLesson: 'State Management Basics',
    isCompleted: false,
    enrolledAt: '2024-01-10',
  ),
  EnrollmentModel(
    id: 2,
    course: mockCourses[1],
    progress: 1.0,
    completedLessons: 32,
    totalLessons: 32,
    currentLesson: 'Final Project',
    isCompleted: true,
    enrolledAt: '2023-12-05',
  ),
  EnrollmentModel(
    id: 3,
    course: mockCourses[3],
    progress: 0.3,
    completedLessons: 9,
    totalLessons: 30,
    currentLesson: 'SEO Fundamentals',
    isCompleted: false,
    enrolledAt: '2024-02-01',
  ),
];

final mockTest = TestModel(
  id: 1,
  title: 'Flutter Basics Test',
  duration: 20,
  totalQuestions: 5,
  questions: [
    const QuestionModel(
      id: 1,
      text: 'What is Flutter?',
      answers: [
        AnswerModel(id: 1, text: 'A JavaScript framework', isCorrect: false),
        AnswerModel(
          id: 2,
          text: 'A Google UI toolkit for mobile, web and desktop',
          isCorrect: true,
        ),
        AnswerModel(id: 3, text: 'A Python library', isCorrect: false),
        AnswerModel(id: 4, text: 'An Apple framework', isCorrect: false),
      ],
    ),
    const QuestionModel(
      id: 2,
      text: 'Which language does Flutter use?',
      answers: [
        AnswerModel(id: 5, text: 'Swift', isCorrect: false),
        AnswerModel(id: 6, text: 'Kotlin', isCorrect: false),
        AnswerModel(id: 7, text: 'Dart', isCorrect: true),
        AnswerModel(id: 8, text: 'JavaScript', isCorrect: false),
      ],
    ),
    const QuestionModel(
      id: 3,
      text: 'What is a Widget in Flutter?',
      answers: [
        AnswerModel(id: 9, text: 'A database component', isCorrect: false),
        AnswerModel(
          id: 10,
          text: 'The basic building block of Flutter UI',
          isCorrect: true,
        ),
        AnswerModel(
          id: 11,
          text: 'A network request handler',
          isCorrect: false,
        ),
        AnswerModel(id: 12, text: 'A state manager', isCorrect: false),
      ],
    ),
    const QuestionModel(
      id: 4,
      text: 'What does StatefulWidget do?',
      answers: [
        AnswerModel(id: 13, text: 'Renders static UI only', isCorrect: false),
        AnswerModel(id: 14, text: 'Handles HTTP requests', isCorrect: false),
        AnswerModel(
          id: 15,
          text: 'Manages mutable state that can change over time',
          isCorrect: true,
        ),
        AnswerModel(id: 16, text: 'Stores local data', isCorrect: false),
      ],
    ),
    const QuestionModel(
      id: 5,
      text: 'Which widget is used for scrollable list in Flutter?',
      answers: [
        AnswerModel(id: 17, text: 'Container', isCorrect: false),
        AnswerModel(id: 18, text: 'ListView', isCorrect: true),
        AnswerModel(id: 19, text: 'Stack', isCorrect: false),
        AnswerModel(id: 20, text: 'Column', isCorrect: false),
      ],
    ),
  ],
);

final mockResult = const ResultModel(
  id: 1,
  testId: 1,
  testTitle: 'Flutter Basics Test',
  score: 80,
  totalQuestions: 5,
  correctAnswers: 4,
  wrongAnswers: 1,
  percentage: 80.0,
  isPassed: true,
  completedAt: '2024-03-15',
);

final mockCertificates = [
  const CertificateModel(
    id: 1,
    courseTitle: 'UI/UX Design with Figma — Pro',
    completionDate: '2024-01-25',
    certificateUrl: '',
  ),
  const CertificateModel(
    id: 2,
    courseTitle: 'Business English for Professionals',
    completionDate: '2024-03-10',
    certificateUrl: '',
  ),
];

final mockReviews = [
  const ReviewModel(
    id: 1,
    userName: 'Sardor Karimov',
    userAvatar: '',
    rating: 5.0,
    comment:
        'This course completely changed my career. The instructor explains everything in a very clear and practical way. Highly recommended!',
    createdAt: '2024-02-20',
  ),
  const ReviewModel(
    id: 2,
    userName: 'Malika Yusupova',
    userAvatar: '',
    rating: 4.5,
    comment:
        'Excellent content and very well structured. I learned so much in just a few weeks. Worth every penny!',
    createdAt: '2024-02-14',
  ),
  const ReviewModel(
    id: 3,
    userName: 'Timur Aliyev',
    userAvatar: '',
    rating: 4.0,
    comment:
        'Good course overall. Some sections could be more detailed but the core content is solid.',
    createdAt: '2024-01-30',
  ),
];

final mockNotifications = [
  const NotificationModel(
    id: 1,
    title: 'New Lesson Available',
    message:
        'Lesson 19: "Advanced State Management" is now available in your Flutter course.',
    type: 'lesson',
    isRead: false,
    createdAt: '2024-03-15T10:30:00',
  ),
  const NotificationModel(
    id: 2,
    title: 'Test Result',
    message: 'You scored 80% on the Flutter Basics Test. Congratulations!',
    type: 'test',
    isRead: false,
    createdAt: '2024-03-14T15:20:00',
  ),
  const NotificationModel(
    id: 3,
    title: 'Course Update',
    message: 'New content has been added to "Flutter Developer Bootcamp 2024".',
    type: 'course',
    isRead: true,
    createdAt: '2024-03-13T09:00:00',
  ),
  const NotificationModel(
    id: 4,
    title: 'Welcome to Learnzilla!',
    message:
        'Your account has been created successfully. Start learning today!',
    type: 'system',
    isRead: true,
    createdAt: '2024-01-10T08:00:00',
  ),
];
