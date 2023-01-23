import 'package:dartz/dartz.dart';
import 'package:fic_mini_project/common/failure.dart';
import 'package:fic_mini_project/domain/entity/user.dart';
import 'package:fic_mini_project/domain/repositories/user_repository.dart';

class GetCurrentUser {
  final UserRepository repository;

  GetCurrentUser(this.repository);

  Future<Either<Failure, User>> execute() {
    return repository.getCurrentUser();
  }
}
