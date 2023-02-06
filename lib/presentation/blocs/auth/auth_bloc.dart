import 'package:equatable/equatable.dart';
import 'package:fic_mini_project/domain/usecases/auth/get_login_status.dart';
import 'package:fic_mini_project/domain/usecases/auth/get_role.dart';
import 'package:fic_mini_project/domain/usecases/auth/login_with_google.dart';
import 'package:fic_mini_project/domain/usecases/auth/logout.dart';
import 'package:fic_mini_project/domain/usecases/auth/set_role.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static const String roleVendor = 'ROLE_VENDOR';
  static const String roleMember = 'ROLE_MEMBER';

  final Login login;
  final GetLoginStatus getLoginStatus;
  final Logout logout;
  final SetRole setRole;
  final GetRole getRole;

  AuthBloc({
    required this.login,
    required this.getLoginStatus,
    required this.logout,
    required this.setRole,
    required this.getRole,
  }) : super(AuthInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(AuthLoading());

      final result = await login.execute();
      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) {
          if (user.role == 'vendor') {
            setRole.execute(roleVendor);
            emit(LoginAsVendorAuthenticated());
          } else {
            setRole.execute(roleMember);
            emit(LoginAsMemberAuthenticated());
          }
        },
      );
    });

    on<LoadLoginStatus>((event, emit) async {
      final status = getLoginStatus.execute();
      final role = await getRole.execute();

      await Future.delayed(const Duration(seconds: 1));

      emit(LoginStatusLoaded(status: status, role: role ?? ''));
    });

    on<LogoutRequested>((event, emit) async {
      await logout.execute();
      emit(LogoutSuccess());
    });
  }
}
