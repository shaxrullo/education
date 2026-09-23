part of 'quizlist_bloc.dart';

@immutable
abstract class QuizlistEvent {}

class QuizRequested extends QuizlistEvent {
  final int courseId;

  QuizRequested({required this.courseId});
}
