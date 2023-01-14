import 'package:fic_mini_project/domain/entity/cart.dart';
import 'package:fic_mini_project/domain/entity/product.dart';

abstract class CartRepository {
  Future<List<Cart>> addProductToCart(Product product);
  Future<List<Cart>> addProductQuantity(Product product);
  Future<List<Cart>> reduceProductQuantity(Product product);
  Future<int> getTotalPrice();
  Future<void> clearCart();
}
