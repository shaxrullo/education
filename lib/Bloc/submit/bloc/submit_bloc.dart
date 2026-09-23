import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:education/Model/resultModel.dart';
import 'package:education/Services/apiClients.dart';
import 'package:education/Services/apikeys.dart';
import 'package:meta/meta.dart';

part 'submit_event.dart';
part 'submit_state.dart';

class SubmitBloc extends Bloc<SubmitEvent, SubmitState> {
  SubmitBloc() : super(SubmitInitial()) {
    on<SubmitRequested>(_onSubmitRequested, transformer: droppable());
  }

  Future<void> _onSubmitRequested(
    SubmitRequested event,
    Emitter<SubmitState> emit,
  ) async {
    emit(SubmitLoading());
    try {
      final response = await apiClients.dio.post(
        "quizzes/${event.quizId}/submit/",
        data: QuizSubmitModel(answers: event.answers).toJson(),
        options: Options(
          headers: {"Authorization": "Bearer ${apiService.accessToken}"},
        ),
      );

      final data = response.data['data'] ?? response.data;
      final QuizSubmitModel result = QuizSubmitModel.fromJson(data);

      emit(SubmitLoaded(result: result));
    } on DioException catch (e) {
      emit(
        SubmitFailure(
          message:
              e.response?.data?.toString() ?? "Natijani yuborishda xatolik",
        ),
      );
    }
  }
}
