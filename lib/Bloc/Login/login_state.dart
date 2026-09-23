part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String refresh;
  final String access;

  LoginSuccess({required this.access, required this.refresh});
}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure({required this.message});
}
