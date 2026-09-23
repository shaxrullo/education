part of 'courseprogress_bloc.dart';

@immutable
abstract class CourseprogressState {}

class CourseprogressInitial extends CourseprogressState {}

class CourseprogresssLoading extends CourseprogressState {}

class CourseprogresssLoaded extends CourseprogressState {
  final CourseProgressmodel lessons;

  CourseprogresssLoaded({required this.lessons});
}

class CourseprogresssFailure extends CourseprogressState {
  final String message;

  CourseprogresssFailure({required this.message});
}
