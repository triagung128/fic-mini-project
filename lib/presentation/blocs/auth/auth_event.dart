part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginAsVendorSubmitted extends AuthEvent {}

class LoginAsMemberSubmitted extends AuthEvent {}

class LoadLoginStatus extends AuthEvent {}

class LogoutRequested extends AuthEvent {}
