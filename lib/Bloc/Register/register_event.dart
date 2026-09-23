part of 'register_bloc.dart';

abstract class RegisterEvent {}



class RegisterRequested extends RegisterEvent {
  final String email;
  final String username;
  final String firstName;
  final String last_name;
  final String phone;
  final String password;
  final String password2;
  final String role;

  RegisterRequested({
    required this.firstName,
    required this.email,
    required this.password,
    required this.last_name,
    required this.password2,
    required this.phone,
    required this.role,
    required this.username,
  });
}

class LogoutRequested extends RegisterEvent {}
