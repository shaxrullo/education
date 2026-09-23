part of 'progress_bloc.dart';

@immutable
abstract class ProgressState {}

class ProgressInitial extends ProgressState {}

class ProgressLoading extends ProgressState {}

class ProgressLoaded extends ProgressState {
  final ProgressModel progresslar;

  ProgressLoaded({required this.progresslar});
}

class ProgressFailure extends ProgressState {
  final String message;
  ProgressFailure({required this.message});
}
