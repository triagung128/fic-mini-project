import 'package:equatable/equatable.dart';
import 'package:fic_mini_project/data/models/category_model.dart';
import 'package:fic_mini_project/domain/entity/product.dart';

class ProductModel extends Equatable {
  final int? id;
  final String name;
  final int price;
  final CategoryModel category;

  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) => ProductModel(
        id: map['id'],
        name: map['name'],
        price: map['price'],
        category: CategoryModel.fromMap({
          'id': map['category_id'],
          'name': map['category_name'],
        }),
      );

  factory ProductModel.fromEntity(Product product) => ProductModel(
        id: product.id,
        name: product.name,
        price: product.price,
        category: CategoryModel.fromEntity(product.category),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'price': price,
        'category_id': category.id,
      };

  Product toEntity() => Product(
        id: id,
        name: name,
        price: price,
        category: category.toEntity(),
      );

  @override
  List<Object?> get props => [id, name, price, category];
}
