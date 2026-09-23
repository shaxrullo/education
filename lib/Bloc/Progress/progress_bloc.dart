import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:education/Model/progressModel.dart';
import 'package:education/Services/apiClients.dart';
import 'package:meta/meta.dart';

part 'progress_event.dart';
part 'progress_state.dart';

class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  ProgressBloc() : super(ProgressInitial()) {
    on<ProgressRequested>(_onProggressRequested, transformer: droppable());
  }

  Future<void> _onProggressRequested(
    ProgressRequested event,
    Emitter<ProgressState> emit,
  ) async {
    emit(ProgressLoading());
    try {
      final response = await apiClients.dio.patch(
        '${event.lessonId}/progress/',
        data: {"second_watched": event.secondsWatched},
      );

      if (response.statusCode == 200 && response.data != null) {
        final progress = ProgressModel.fromJson(response.data);
        emit(ProgressLoaded(progresslar: progress));
      } else {
        emit(ProgressFailure(message: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      emit(ProgressFailure(message: e.toString()));
    }
  }
}
