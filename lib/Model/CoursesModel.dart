import 'package:education/Model/CourseCatgoryModel.dart';
import 'package:education/Model/TeacherModel.dart';

class CourseModel {
  final int id;
  final String title;
  final String? shortDescription;
  final String? image;
  CourseCategoryModel category; // nested obyekt
  final Teachermodel teacher; // nested obyekt
  final String? level; // "beginner" | "intermediate" | "advanced"
  final int? duration;
  final String? language;
  final bool? isPublished;
  final int lessonCount;
  final int studentCount;
  final DateTime createdAt;

  CourseModel({
    required this.id,
    required this.title,
    this.shortDescription,
    this.image,
    required this.category,
    required this.teacher,
    this.level,
    this.duration,
    this.language,
    this.isPublished,
    required this.lessonCount,
    required this.studentCount,
    required this.createdAt,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      title: json['title'] ?? '',
      shortDescription: json['short_description'],
      image: json['image'],
      category: CourseCategoryModel.fromJson(json['category']),
      teacher: Teachermodel.fromJson(json['teacher']),
      level: json['level'],
      duration: json['duration'],
      language: json['language'],
      isPublished: json['is_published'],
      lessonCount: json['lesson_count'] ?? 0,
      studentCount: json['student_count'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
