import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:education/Model/lessonModel.dart';
import 'package:education/Services/apiClients.dart';
import 'package:education/Services/apikeys.dart';
import 'package:meta/meta.dart';

part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  LessonBloc() : super(LessonInitial()) {
    on<LessonRequested>(_onLessonRequested, transformer: droppable());
  }

  // lesson_bloc.dart
Future<void> _onLessonRequested(
  LessonRequested event,
  Emitter<LessonState> emit,
) async {
  emit(LessonLoading());
  try {
    final response = await apiClients.dio.get(
      "courses/${event.lessonId}/lessons/",
      options: Options(
        headers: {"Authorization": "Bearer ${apiService.accessToken}"},
      ),
    );

    print(response.data);

    final data = response.data['data'] ?? response.data;
    final List<dynamic> rawList = data is Map ? (data['results'] ?? []) : data;
    final List<LessonModel> lessons = rawList
        .map((item) => LessonModel.fromJson(item))
        .toList();

    emit(LessonLoaded(lessons: lessons));
  } on DioException catch (e) {
    emit(
      LessonFailure(
        message: e.response?.data?.toString() ?? "Darslar kelmadi",
      ),
    );
  }
}

}
