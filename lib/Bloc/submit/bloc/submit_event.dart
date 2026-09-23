part of 'submit_bloc.dart';

@immutable
abstract class SubmitEvent {}

class SubmitRequested extends SubmitEvent {
  final int quizId;
  final List<AnswerRequest> answers;
  SubmitRequested({required this.quizId, required this.answers});
}
