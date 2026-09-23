import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:education/Services/apiClients.dart';
import 'package:education/Services/apikeys.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterRequested>(_onRegisterRequested, transformer: droppable());
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      final response = await apiClients.dio.post(
        "auth/register/",
        data: {
          "email": event.email,
          "username": event.username,
          "first_name": event.firstName,
          "last_name": event.last_name,
          "phone": event.phone,
          "password": event.password,
          "password2": event.password2,
          "role": event.role,
        },
      );

      print(response.data);

    } on DioException catch (e) {
      print("STATUS: ${e.response?.statusCode}");
      print("DATA: ${e.response?.data}");
      print("TYPE: ${e.type}");
      emit(
        RegisterFailure(
          message:
              e.response?.data?.toString() ?? "Ro'yxatdan o'tishda xatolik",
        ),
      );
    }
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<RegisterState> emit) {
    apiService.accessToken = null;
    apiService.refreshToken = null;
    emit(RegisterInitial());
  }
}
