import 'package:dartz/dartz.dart';
import 'package:fic_mini_project/common/failure.dart';
import 'package:fic_mini_project/domain/entity/user.dart';
import 'package:fic_mini_project/domain/repositories/auth_repository.dart';

class Login {
  final AuthRepository repository;

  Login(this.repository);

  Future<Either<Failure, User>> execute() {
    return repository.loginWithGoogle();
  }
}
