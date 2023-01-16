import 'package:fic_mini_project/domain/entity/product.dart';

class ProductCartModel {
  final int? id;
  final String name;
  final int price;
  int quantity;

  ProductCartModel({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 0,
  });

  factory ProductCartModel.fromMap(Map<String, dynamic> map) =>
      ProductCartModel(
        id: map['id'],
        name: map['name'],
        price: map['price'],
        quantity: map['quantity'],
      );

  factory ProductCartModel.fromEntity(Product product) => ProductCartModel(
        id: product.id,
        name: product.name,
        price: product.price,
        quantity: product.quantity,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'price': price,
        'quantity': quantity,
      };

  Product toEntity() => Product.cart(
        id: id,
        name: name,
        price: price,
        quantity: quantity,
      );
}
