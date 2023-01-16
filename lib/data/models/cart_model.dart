import 'package:fic_mini_project/data/models/product_cart_model.dart';
import 'package:fic_mini_project/domain/entity/cart.dart';

class CartModel {
  final List<ProductCartModel> products;
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
        'products': products.map((item) => item.toMap()).toList(),
        'total_price': totalPrice,
      };

  factory CartModel.fromMap(Map<String, dynamic> map) => CartModel(
        products: List<ProductCartModel>.from(
          map['products'].map((product) => ProductCartModel.fromMap(product)),
        ),
        totalPrice: map['total_price'],
      );
}
