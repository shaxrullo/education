class CourseProgressmodel {
  final int courseId;
  final int totalLessons;
  final int completedLessons;
  final double progressPercent;
  final List<LessonProgressItem> lessonProgress;

  CourseProgressmodel({
    required this.courseId,
    required this.totalLessons,
    required this.completedLessons,
    required this.progressPercent,
    required this.lessonProgress,
  });

  factory CourseProgressmodel.fromJson(Map<String, dynamic> json) {
    return CourseProgressmodel(
      // 1-tuzatish: snake_case kalitlar - backend shunday qaytaryapti
      courseId: json['course_id'] ?? 0,
      totalLessons: json['total_lessons'] ?? 0,
      completedLessons: json['completed_lessons'] ?? 0,
      progressPercent: json['progress_percent'] != null
          ? (json['progress_percent'] as num).toDouble()
          : 0.0,
      // 2-tuzatish: bitta obyekt emas, RO'YXAT - har biri alohida parse qilinadi
      lessonProgress: (json['lesson_progress'] as List<dynamic>? ?? [])
          .map((item) => LessonProgressItem.fromJson(item))
          .toList(),
    );
  }
}

class LessonProgressItem {
  final int id;
  final int lesson;
  final String lessonTitle;
  final int courseId;
  final bool isCompleted;
  final String? completedAt;
  final int watchedSeconds;

  LessonProgressItem({
    required this.id,
    required this.lesson,
    required this.lessonTitle,
    required this.courseId,
    required this.isCompleted,
    this.completedAt,
    required this.watchedSeconds,
  });

  factory LessonProgressItem.fromJson(Map<String, dynamic> json) {
    return LessonProgressItem(
      id: json['id'] ?? 0,
      lesson: json['lesson'] ?? 0,
      lessonTitle: json['lesson_title'] ?? '',
      courseId: json['course_id'] ?? 0,
      isCompleted: json['is_completed'] ?? false,
      completedAt: json['completed_at'],
      watchedSeconds: json['watched_seconds'] ?? 0,
    );
  }
}