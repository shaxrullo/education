import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:education/Model/completeModel.dart';
import 'package:education/Services/apiClients.dart';
import 'package:education/Services/apikeys.dart';
import 'package:meta/meta.dart';

part 'complete_event.dart';
part 'complete_state.dart';

class CompleteBloc extends Bloc<CompleteEvent, CompleteState> {
  CompleteBloc() : super(CompleteInitial()) {
    on<CompleteRequest>(_onCompleteRequest, transformer: droppable());
  }

  Future<void> _onCompleteRequest(
    CompleteRequest event,
    Emitter<CompleteState> emit,
  ) async {
    emit(CompleteLoading());
    try {
      final response = await apiClients.dio.post(
        "lessons/${event.lessonId}/complete/",
        options: Options(
          headers: {"Authorization": "Bearer ${apiService.accessToken}"},
        ),
      );

      final data = response.data['data'] ?? response.data;
final complete = Completemodel.fromJson(data);

      emit(CompleteLoaded(complete: [complete]));
    } on DioException catch (e) {
      print(e.response?.statusCode);
      print(e.response?.data);
      emit(CompleteFailure(message: e.response?.data?.toString() ?? "Xato"));
    } catch (e) {
      emit(
        CompleteFailure(message: "Kutilmagan xatolik: $e"),
      ); // bu qo'shilganmi?
    }
  }
}
