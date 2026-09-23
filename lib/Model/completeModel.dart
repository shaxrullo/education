class Completemodel {
  final int id;
  final int lesson;
  final String lessonTitle;
  final bool isCompleted;
  final String? completedAt;
  final int watchedSeconds;

  Completemodel({
    required this.completedAt,
    required this.id,
    required this.isCompleted,
    required this.lesson,
    required this.lessonTitle,
    required this.watchedSeconds,
  });

  factory Completemodel.fromJson(Map<String, dynamic> json) {
    return Completemodel(
      id: json['id'],
      lesson: json['lesson'],
      lessonTitle: json['lesson_title'],
      isCompleted: json['is_completed'],
      completedAt: json['completed_at'],
      watchedSeconds: json['watched_seconds'],
    );
  }
}
