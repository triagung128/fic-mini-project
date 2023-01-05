part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class OnFetchAllProducts extends ProductEvent {}

class OnCreateProduct extends ProductEvent {
  final Product product;

  const OnCreateProduct(this.product);

  @override
  List<Object> get props => [product];
}

class OnUpdateProduct extends ProductEvent {
  final Product product;

  const OnUpdateProduct(this.product);

  @override
  List<Object> get props => [product];
}

class OnDeleteProduct extends ProductEvent {
  final Product product;

  const OnDeleteProduct(this.product);

  @override
  List<Object> get props => [product];
}
