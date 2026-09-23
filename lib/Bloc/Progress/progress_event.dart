part of 'progress_bloc.dart';

@immutable
abstract class ProgressEvent {}

class ProgressRequested extends ProgressEvent {
  final int lessonId;
  final int secondsWatched;

  ProgressRequested({required this.lessonId, required this.secondsWatched});
}
