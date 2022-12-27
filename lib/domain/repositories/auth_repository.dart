import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fic_mini_project/common/failure.dart';
import 'package:fic_mini_project/domain/entity/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> loginWithGoogle();
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, String>> updateUser(User user);
  Future<Either<Failure, String>> updateUserImage(String fileName, File file);
  bool getLoginStatus();
  Future<String?> getRole();
  Future<void> setRole(String role);
  Future<void> logout();
}
