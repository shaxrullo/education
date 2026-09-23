import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:education/Model/LessonDetailsModel.dart';
import 'package:education/Services/apiClients.dart';
import 'package:education/Services/apikeys.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'lesson_detail_event.dart';
part 'lesson_detail_state.dart';

class LessonDetailBloc extends Bloc<LessonDetailEvent, LessonDetailState> {
  LessonDetailBloc() : super(LessonDetailInitial()) {
    on<LessonDetailsRequested>(_onLessonDetailsRequested, transformer: droppable());
  }

  Future<void> _onLessonDetailsRequested(
    LessonDetailsRequested event,
    Emitter<LessonDetailState> emit,
  ) async {
    emit(LessonDetailLoading());
    try {
      final response = await apiClients.dio.get(
        "lessons/${event.lessonId}/",
        options: Options(
          headers: {"Authorization": "Bearer ${apiService.accessToken}"},
        ),
      );

      print(response.data);

      final data = response.data['data'] ?? response.data;
      final List<dynamic> rawList = data is Map
          ? (data['results'] ?? [])
          : data;
      final List<LessonDetailsModel> lessonDetails = rawList
          .map((item) => LessonDetailsModel.fromJson(item))
          .toList();

      emit(LessonDetailLoaded(lessonDetails: lessonDetails));
    } on DioException catch (e) {
      emit(
      LessonDetailFailure(
        message: e.response?.data?.toString() ?? "Darslar kelmadi",
      ),
    );
    }
  }
}
