import 'package:fic_mini_project/data/models/product_model.dart';
import 'package:fic_mini_project/domain/entity/cart.dart';

class CartModel {
  final List<ProductModel> products;
  int totalPrice;

  CartModel({
    required this.products,
    this.totalPrice = 0,
  });

  Cart toEntity() => Cart(
        products: products.map((item) => item.toEntity()).toList(),
        totalPrice: totalPrice,
      );

  Map<String, dynamic> toMap() => {
        'products': products.map((item) => item.toCartMap()).toList(),
        'total_price': totalPrice,
      };
}
