part of 'lesson_bloc.dart';

@immutable
abstract class LessonState {}

class LessonInitial extends LessonState {}

class LessonLoading extends LessonState {}

class LessonLoaded extends LessonState {
  final List<LessonModel> lessons;

  LessonLoaded({required this.lessons});
}

class LessonFailure extends LessonState {
  final String message;
  LessonFailure({required this.message});
}
