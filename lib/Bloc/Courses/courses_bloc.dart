import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:education/Model/CoursesModel.dart';
import 'package:education/Services/apiClients.dart';
import 'package:education/Services/apikeys.dart';
import 'package:meta/meta.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  CoursesBloc() : super(CoursesInitial()) {
    on<CoursesRequested>(_onCoursesRequested, transformer: droppable());
  }

  Future<void> _onCoursesRequested(
    CoursesRequested event,
    Emitter<CoursesState> emit,
  ) async {
    emit(CoursesLoading());
    try {
      final response = await apiClients.dio.get(
        "courses/",
        options: Options(
          headers: {"Authorization": "Bearer ${apiService.accessToken}"},
        ),
      );
      final data = response.data['data'] ?? response.data;
      final List<dynamic> rawList = data['results'] ?? data;
      final List<CourseModel> courses = rawList
          .map((item) => CourseModel.fromJson(item))
          .toList();
          print(response.data);
      emit(CoursesLoaded(courses: courses));
    } on DioException catch (e) {
      emit(
        CoursesFailure(
          message: e.response?.data?.toString() ?? "Kurslar kelmadi",
        ),
      );
    }
  }
}
