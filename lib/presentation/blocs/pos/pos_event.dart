part of 'pos_bloc.dart';

abstract class PosEvent extends Equatable {
  const PosEvent();

  @override
  List<Object> get props => [];
}

class OnClearCart extends PosEvent {}

class OnAddProductToCart extends PosEvent {
  final Product product;

  const OnAddProductToCart(this.product);

  @override
  List<Object> get props => [product];
}

class OnAddProductQuantity extends PosEvent {
  final Product product;

  const OnAddProductQuantity(this.product);

  @override
  List<Object> get props => [product];
}

class OnReduceProductQuantity extends PosEvent {
  final Product product;

  const OnReduceProductQuantity(this.product);

  @override
  List<Object> get props => [product];
}

class OnPosAction extends PosEvent {}
