import 'package:equatable/equatable.dart';
import 'package:fic_mini_project/domain/entity/category.dart';

class Product extends Equatable {
  final int? id;
  final String name;
  final int price;
  final Category category;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
  });

  @override
  List<Object?> get props => [id, name, price, category];
}
