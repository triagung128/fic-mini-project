import 'package:dartz/dartz.dart';

import 'package:fic_mini_project/common/failure.dart';
import 'package:fic_mini_project/domain/entity/category.dart';
import 'package:fic_mini_project/domain/repositories/category_repository.dart';

class UpdateCategory {
  final CategoryRepository repository;

  UpdateCategory(this.repository);

  Future<Either<Failure, String>> execute(Category category) {
    return repository.updateCategory(category);
  }
}
