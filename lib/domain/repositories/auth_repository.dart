import 'package:dartz/dartz.dart';
import 'package:fic_mini_project/common/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> loginWithGoogle();
  bool getLoginStatus();
  Future<String?> getRole();
  Future<void> setRole(String role);
  Future<void> logout();
}
