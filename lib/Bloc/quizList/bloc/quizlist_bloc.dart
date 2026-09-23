import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:education/Model/quizModel.dart';
import 'package:education/Services/apiClients.dart';
import 'package:education/Services/apikeys.dart';
import 'package:meta/meta.dart';

part 'quizlist_event.dart';
part 'quizlist_state.dart';

class QuizlistBloc extends Bloc<QuizlistEvent, QuizlistState> {
  QuizlistBloc() : super(QuizlistInitial()) {
    on<QuizRequested>(_onQuizRequested, transformer: droppable());
  }

  Future<void> _onQuizRequested(
    QuizRequested event,
    Emitter<QuizlistState> emit,
  ) async {
    emit(QuizlistLoading());
    try {
      final response = await apiClients.dio.get(
        "courses/${event.courseId}/quizzes/",
        options: Options(
          headers: {"Authorization": "Bearer ${apiService.accessToken}"},
        ),
      );

      print(response.data);

      final data = response.data['data'] ?? response.data;
      final List<dynamic> rawList = data is Map
          ? (data['results'] ?? [])
          : data;
      final List<QuizModel> quizesList = rawList
          .map((item) => QuizModel.fromJson(item))
          .toList();

      emit(QuizlistLoaded(quizes: quizesList));
    } on DioException catch (e) {
      emit(
        QuizlistFailure(
          message: e.response?.data?.toString() ?? "Darslar kelmadi",
        ),
      );
    } catch (e) {
      emit(
        QuizlistFailure(message: "Kutilmagan xatolik: $e"),
      ); 
    }
  }
}
