class LessonDetailsModel {
  final int id;
  final int courseId;
  final String title;
  final String description;
  final String videoUrl;
  final String? thumbnail;
  final String content;
  final int order;
  final int duration;
  final bool isFree;
  final String createdAt;

  LessonDetailsModel({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.videoUrl,
    this.thumbnail,
    required this.content,
    required this.order,
    required this.duration,
    required this.isFree,
    required this.createdAt,
  });

  factory LessonDetailsModel.fromJson(Map<String, dynamic> json) {
    return LessonDetailsModel(
      id: json['id'],
      courseId: json['course'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      videoUrl: json['video_url'] ?? '',
      thumbnail: json['thumbnail'],
      content: json['content'] ?? '',
      order: json['order'] ?? 0,
      duration: json['duration'] ?? 0,
      isFree: json['is_free'] ?? false,
      createdAt: json['created_at'] ?? '',
    );
  }
}
