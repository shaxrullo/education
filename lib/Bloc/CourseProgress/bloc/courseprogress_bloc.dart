import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:education/Model/CourseProgressModel.dart';
import 'package:education/Services/apiClients.dart';
import 'package:education/Services/apikeys.dart';
import 'package:meta/meta.dart';

part 'courseprogress_event.dart';
part 'courseprogress_state.dart';

class CourseprogressBloc
    extends Bloc<CourseprogressEvent, CourseprogressState> {
  CourseprogressBloc() : super(CourseprogressInitial()) {
    on<CourseProgressRequested>(
      _onCourseProgressRequested,
      transformer: droppable(),
    );
  }

  Future<void> _onCourseProgressRequested(
    CourseProgressRequested event,
    Emitter<CourseprogressState> emit,
  ) async {
    emit(CourseprogresssLoading());
    try {
      final response = await apiClients.dio.get(
        'courses/${event.courseId}/progress/',
        options: Options(
          headers: {"Authorization": "Bearer ${apiService.accessToken}"},
        ),
      );
      print(response.data); // shuni qo'shing, to'liq JSON'ni ko'rish uchun
      final data = response.data['data'] ?? response.data;
          final progress = CourseProgressmodel.fromJson(data);
      emit(CourseprogresssLoaded(lessons: progress));
    } on DioException catch (e) {
      print("STATUS: ${e.response?.statusCode}");
      print("DATA: ${e.response?.data}");
      emit(CourseprogresssFailure(message: e.response!.data));
    }
    ;
  }
}
