import 'package:equatable/equatable.dart';
import 'package:fic_mini_project/domain/entity/product.dart';

class Cart extends Equatable {
  final List<Product> products;
  final int totalPrice;

  const Cart({
    required this.products,
    this.totalPrice = 0,
  });

  @override
  List<Object?> get props => [products, totalPrice];
}
