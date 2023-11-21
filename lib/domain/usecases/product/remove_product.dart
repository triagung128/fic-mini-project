import 'package:dartz/dartz.dart';

import 'package:fic_mini_project/common/failure.dart';
import 'package:fic_mini_project/domain/entity/product.dart';
import 'package:fic_mini_project/domain/repositories/product_repository.dart';

class RemoveProduct {
  final ProductRepository repository;

  RemoveProduct(this.repository);

  Future<Either<Failure, String>> execute(Product product) {
    return repository.removeProduct(product);
  }
}
