class LessonModel {
  final int? id;
  final int? course;
  final String title;
  final String description;
  final String videoUrl;
  final String? thumbnail;
  final String content;
  final int order;
  final int duration;
  final bool isFree;
  final String? createdAt;

  LessonModel({
    this.id,
    this.course,
    required this.title,
    required this.description,
    required this.videoUrl,
    this.thumbnail,
    required this.content,
    required this.order,
    required this.duration,
    required this.isFree,
    this.createdAt,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'],
      course: json['course'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      videoUrl: json['video_url'] ?? '',
      thumbnail: json['thumbnail'],
      content: json['content'] ?? '',
      order: json['order'] ?? 0,
      duration: json['duration'] ?? 0,
      isFree: json['is_free'] ?? false,
      createdAt: json['created_at'],
    );
  }
}
