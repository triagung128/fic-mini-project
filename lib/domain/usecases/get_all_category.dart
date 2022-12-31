import 'package:dartz/dartz.dart';
import 'package:fic_mini_project/common/failure.dart';
import 'package:fic_mini_project/domain/entity/category.dart';
import 'package:fic_mini_project/domain/repositories/category_repository.dart';

class GetAllCategory {
  final CategoryRepository repository;

  GetAllCategory(this.repository);

  Future<Either<Failure, List<Category>>> execute() {
    return repository.getAllCategory();
  }
}
