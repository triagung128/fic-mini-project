import 'package:dartz/dartz.dart';
import 'package:fic_mini_project/common/failure.dart';
import 'package:fic_mini_project/domain/entity/user.dart';
import 'package:fic_mini_project/domain/repositories/auth_repository.dart';

class UpdateUser {
  final AuthRepository repository;

  UpdateUser(this.repository);

  Future<Either<Failure, String>> execute(User user) {
    return repository.updateUser(user);
  }
}
