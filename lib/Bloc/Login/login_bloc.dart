import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:education/Model/UserModel.dart';
import 'package:education/Services/apiClients.dart';
import 'package:education/Services/apikeys.dart';
import 'package:education/Services/storageServises.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested, transformer: droppable());
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final response = await apiClients.dio.post(
        "auth/login/",
        data: {"email": event.email, "password": event.password},
      );
      final data = response.data["data"]; // avval shu qator qo'shiladi

      final access = data["access"];
      final refresh = data["refresh"];
      final user = UserModel.fromJson(data["user"]);

      // 2-tuzatish: apiService fieldlariga yozish — bu qadam butunlay yo'q edi
      apiService.accessToken = access;
      apiService.refreshToken = refresh;
      apiService.currentUser = user;

      if (response.statusCode == 200) {
        final String token = data['access'];
        print("Mukkmal tarzada saqladim ");
        // Tokenni SharedPreferences'ga saqlaymiz
        await storageService.saveToken(token);
        print("Mukkmal tarzada saqladim ");

      }
      emit(LoginSuccess(access: access, refresh: refresh));
    } on DioException catch (e) {
      print("STATUS: ${e.response?.statusCode}");
      print("DATA: ${e.response?.data}");
      print("TYPE: ${e.type}");
      emit(
        LoginFailure(
          message: e.response?.data?.toString() ?? "Parool yoki email xato",
        ),
      );
    } catch (e) {
      // 3-tuzatish: DioException bo'lmagan xatolarni ham ushlash,
      // aks holda ilova "jim" qolib, siz sababini hech qachon SnackBar'da ko'rmaysiz
      emit(LoginFailure(message: "Kutilmagan xatolik: $e"));
    }
  }
}
