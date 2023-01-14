import 'package:fic_mini_project/domain/entity/product.dart';

class Cart {
  final Product product;
  int quantity;

  Cart({
    required this.product,
    this.quantity = 0,
  });
}
