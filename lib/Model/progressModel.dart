class ProgressModel {
  int id;
  int lesson;
  String lessonTitle;
  int courseId;
  bool iCompleted;
  final DateTime? completedAt;
  int watchSeconds;

  ProgressModel({
    required this.courseId,
    required this.iCompleted,
    required this.id,
    required this.lesson,
    required this.lessonTitle,
    required this.watchSeconds,
    required this.completedAt,
  });

  factory ProgressModel.fromJson(Map<String, dynamic> json) {
    return ProgressModel(
      courseId: json['courseId'],
      iCompleted: json['iCompleted'],
      completedAt: json['completed_at'] != null
          ? DateTime.tryParse(json['completed_at'].toString())
          : null,
      id: json['id'],
      lesson: json['lesson'],
      lessonTitle: json['lessonTitle'],
      watchSeconds: json['watchSeconds'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lesson': lesson,
      'lesson_title': lessonTitle,
      'course_id': courseId,
      'is_completed': iCompleted,
      'completed_at': completedAt?.toIso8601String(),
      'watched_seconds': watchSeconds,
    };
  }
}
