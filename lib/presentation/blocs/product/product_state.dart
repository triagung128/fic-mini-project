part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductFailure extends ProductState {
  final String message;

  const ProductFailure(this.message);

  @override
  List<Object> get props => [message];
}

class ProductEmpty extends ProductState {}

class AllProductsLoaded extends ProductState {
  final List<Product> products;

  const AllProductsLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductActionSuccess extends ProductState {
  final String message;

  const ProductActionSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ProductActionFailure extends ProductState {
  final String message;

  const ProductActionFailure(this.message);

  @override
  List<Object> get props => [message];
}
