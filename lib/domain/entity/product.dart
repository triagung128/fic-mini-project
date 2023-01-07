import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:fic_mini_project/domain/entity/category.dart';

class Product extends Equatable {
  final int? id;
  final String name;
  final int price;
  final Category category;
  final Uint8List image;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.image,
  });

  @override
  List<Object?> get props => [id, name, price, category, image];
}
