import 'package:fic_mini_project/domain/entity/cart.dart';
import 'package:fic_mini_project/domain/entity/product.dart';
import 'package:fic_mini_project/domain/repositories/cart_repository.dart';

class ReduceProductQuantity {
  final CartRepository repository;

  ReduceProductQuantity(this.repository);

  Future<Cart> execute(Product product) {
    return repository.reduceProductQuantity(product);
  }
}
