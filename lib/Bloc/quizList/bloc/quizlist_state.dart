part of 'quizlist_bloc.dart';

@immutable
abstract class QuizlistState {}

class QuizlistInitial extends QuizlistState {}

class QuizlistLoading extends QuizlistState {}

class QuizlistLoaded extends QuizlistState {
  final List<QuizModel> quizes;

  QuizlistLoaded({required this.quizes});
}

class QuizlistFailure extends QuizlistState {
  final String message;

  QuizlistFailure({required this.message});
}
