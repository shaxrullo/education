part of 'courses_bloc.dart';

@immutable
abstract class CoursesState {}

class CoursesInitial extends CoursesState {}

class CoursesLoading extends CoursesState {}

class CoursesLoaded extends CoursesState {

  final List<CourseModel> courses;
  CoursesLoaded({required this.courses});
}

class CoursesFailure extends CoursesState {
  final String message;
  CoursesFailure({required this.message});
}
