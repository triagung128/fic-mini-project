part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}

class LoginAsVendorAuthenticated extends AuthState {}

class LoginAsMemberAuthenticated extends AuthState {}

class LoginStatusLoaded extends AuthState {
  final bool status;
  final String role;

  const LoginStatusLoaded({required this.status, required this.role});

  @override
  List<Object> get props => [status, role];
}

class LogoutSuccess extends AuthState {}
