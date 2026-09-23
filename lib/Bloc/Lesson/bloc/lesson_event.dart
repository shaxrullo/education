part of 'lesson_bloc.dart';

@immutable
abstract class LessonEvent {}

class LessonRequested extends LessonEvent{
  final int lessonId;
  LessonRequested({required this.lessonId});
}