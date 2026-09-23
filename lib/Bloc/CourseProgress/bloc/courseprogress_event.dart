part of 'courseprogress_bloc.dart';

@immutable
abstract class CourseprogressEvent {}

class CourseProgressRequested extends CourseprogressEvent {
  final int courseId;

  CourseProgressRequested({required this.courseId});
}
