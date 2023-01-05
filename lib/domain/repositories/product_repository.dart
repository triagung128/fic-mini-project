import 'package:dartz/dartz.dart';
import 'package:fic_mini_project/common/failure.dart';
import 'package:fic_mini_project/domain/entity/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, String>> insertProduct(Product product);
  Future<Either<Failure, String>> updateProduct(Product product);
  Future<Either<Failure, String>> removeProduct(Product product);
}
