import 'package:dartz/dartz.dart';
import 'package:fic_mini_project/common/failure.dart';
import 'package:fic_mini_project/domain/repositories/category_repository.dart';

class RemoveCategory {
  final CategoryRepository repository;

  RemoveCategory(this.repository);

  Future<Either<Failure, String>> execute(int id) {
    return repository.removeCategory(id);
  }
}
