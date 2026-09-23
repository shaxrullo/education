part of 'complete_bloc.dart';

@immutable
abstract class CompleteState {}

class CompleteInitial extends CompleteState {}

class CompleteLoading extends CompleteState {}

class CompleteLoaded extends CompleteState {
  final List<Completemodel> complete;

  CompleteLoaded({required this.complete});
}

class CompleteFailure extends CompleteState {
  final String message;

  CompleteFailure({required this.message});
}
