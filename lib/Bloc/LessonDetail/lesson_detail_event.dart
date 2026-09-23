part of 'lesson_detail_bloc.dart';

@immutable
abstract class LessonDetailEvent {}

class LessonDetailsRequested extends LessonDetailEvent {
  final int lessonId;
  LessonDetailsRequested({required this.lessonId});
}
