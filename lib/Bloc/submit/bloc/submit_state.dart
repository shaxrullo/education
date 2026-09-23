part of 'submit_bloc.dart';

@immutable
abstract class SubmitState {}

class SubmitInitial extends SubmitState {}

class SubmitLoading extends SubmitState {}

class SubmitLoaded extends SubmitState {
  final QuizSubmitModel result;
  SubmitLoaded({required this.result});
}

class SubmitFailure extends SubmitState {
  final String message;
  SubmitFailure({required this.message});
}
