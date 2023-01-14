import 'package:fic_mini_project/domain/entity/cart.dart';
import 'package:fic_mini_project/domain/entity/product.dart';
import 'package:fic_mini_project/domain/repositories/cart_repository.dart';

class AddProductQuantity {
  final CartRepository repository;

  AddProductQuantity(this.repository);

  Future<List<Cart>> execute(Product product) {
    return repository.addProductQuantity(product);
  }
}
