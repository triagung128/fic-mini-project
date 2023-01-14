import 'package:fic_mini_project/data/models/cart_model.dart';
import 'package:fic_mini_project/data/models/product_model.dart';
import 'package:fic_mini_project/domain/entity/cart.dart';
import 'package:fic_mini_project/domain/entity/product.dart';
import 'package:fic_mini_project/domain/repositories/cart_repository.dart';

class CartRepositoryImpl extends CartRepository {
  final CartModel _carts = CartModel(products: [], totalPrice: 0);

  int getTotalPrice() {
    int total = 0;
    for (var item in _carts.products) {
      total += (item.quantity * item.price);
    }
    return total;
  }

  @override
  Future<Cart> addProductToCart(Product product) async {
    final productFromEntity = ProductModel.fromEntity(product)..quantity = 1;
    _carts.products.add(productFromEntity);
    _carts.totalPrice = getTotalPrice();

    return _carts.toEntity();
  }

  @override
  Future<Cart> addProductQuantity(Product product) async {
    int index = _carts.products.indexWhere(
      (item) => item.id == ProductModel.fromEntity(product).id,
    );
    _carts.products[index].quantity++;
    _carts.totalPrice = getTotalPrice();

    return _carts.toEntity();
  }

  @override
  Future<Cart> reduceProductQuantity(Product product) async {
    int index = _carts.products.indexWhere(
      (item) => item.id == ProductModel.fromEntity(product).id,
    );
    _carts.products[index].quantity--;

    if (_carts.products[index].quantity == 0) _carts.products.removeAt(index);

    _carts.totalPrice = getTotalPrice();

    return _carts.toEntity();
  }

  @override
  Future<void> clearCart() async {
    _carts.products.clear();
    _carts.totalPrice = 0;
  }

  @override
  Future<Map<String, dynamic>> getAllCartsMap() async {
    return _carts.toMap();
  }
}
