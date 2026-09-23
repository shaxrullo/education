part of 'lesson_detail_bloc.dart';

@immutable
abstract class LessonDetailState {}

class LessonDetailInitial extends LessonDetailState {}

class LessonDetailLoading extends LessonDetailState {}

class LessonDetailLoaded extends LessonDetailState {
  final List<LessonDetailsModel> lessonDetails;

  LessonDetailLoaded({required this.lessonDetails});
}

class LessonDetailFailure extends LessonDetailState {
  final String message;

  LessonDetailFailure({required this.message});
}
