import 'package:dartz/dartz.dart';
import 'package:fic_mini_project/common/failure.dart';
import 'package:fic_mini_project/domain/entity/product.dart';
import 'package:fic_mini_project/domain/repositories/product_repository.dart';

class GetAllProducts {
  final ProductRepository repository;

  GetAllProducts(this.repository);

  Future<Either<Failure, List<Product>>> execute() {
    return repository.getAllProducts();
  }
}
