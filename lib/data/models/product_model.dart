import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:fic_mini_project/data/models/category_model.dart';
import 'package:fic_mini_project/domain/entity/product.dart';

// ignore: must_be_immutable
class ProductModel extends Equatable {
  final int? id;
  final String name;
  final int price;
  final CategoryModel category;
  final Uint8List image;
  int quantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.image,
    this.quantity = 0,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) => ProductModel(
        id: map['id'],
        name: map['name'],
        price: map['price'],
        category: CategoryModel.fromMap({
          'id': map['category_id'],
          'name': map['category_name'],
        }),
        image: map['image'],
      );

  factory ProductModel.fromEntity(Product product) => ProductModel(
        id: product.id,
        name: product.name,
        price: product.price,
        category: CategoryModel.fromEntity(product.category),
        image: product.image,
        quantity: product.quantity,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'price': price,
        'category_id': category.id,
        'image': image,
      };

  Map<String, dynamic> toCartMap() => {
        'id': id,
        'name': name,
        'price': price,
      };

  Product toEntity() => Product(
        id: id,
        name: name,
        price: price,
        category: category.toEntity(),
        image: image,
        quantity: quantity,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        category,
        image,
        quantity,
      ];
}
