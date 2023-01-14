import 'package:fic_mini_project/domain/entity/cart.dart';
import 'package:fic_mini_project/domain/entity/product.dart';
import 'package:fic_mini_project/domain/repositories/cart_repository.dart';

class CartRepositoryImpl extends CartRepository {
  final List<Cart> _carts = [];

  @override
  Future<List<Cart>> addProductToCart(Product product) async {
    _carts.add(
      Cart(
        product: product,
        quantity: 1,
      ),
    );

    return _carts;
  }

  @override
  Future<List<Cart>> addProductQuantity(Product product) async {
    int index = _carts.indexWhere((item) => item.product.id == product.id);
    _carts[index].quantity++;

    return _carts;
  }

  @override
  Future<List<Cart>> reduceProductQuantity(Product product) async {
    int index = _carts.indexWhere((item) => item.product.id == product.id);
    _carts[index].quantity--;

    if (_carts[index].quantity == 0) _carts.removeAt(index);

    return _carts;
  }

  @override
  Future<int> getTotalPrice() async {
    int total = 0;
    for (var item in _carts) {
      total += (item.quantity * item.product.price);
    }
    return total;
  }

  @override
  Future<void> clearCart() async {
    _carts.clear();
  }
}
