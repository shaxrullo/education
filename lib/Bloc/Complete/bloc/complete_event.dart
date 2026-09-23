part of 'complete_bloc.dart';

@immutable
abstract class CompleteEvent {}

class CompleteRequest extends CompleteEvent{
  final int lessonId;
  CompleteRequest({required this.lessonId});
}