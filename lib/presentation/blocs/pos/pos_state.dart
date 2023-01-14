part of 'pos_bloc.dart';

class PosState extends Equatable {
  final Cart cart;
  final PosActionState actionState;
  final Map<String, dynamic> cartMap;

  const PosState({
    required this.cart,
    required this.actionState,
    required this.cartMap,
  });

  @override
  List<Object> get props => [cart, actionState, cartMap];

  factory PosState.initial() {
    return const PosState(
      cart: Cart(products: []),
      actionState: PosActionState.noAction,
      cartMap: {},
    );
  }

  PosState copyWith({
    Cart? cart,
    PosActionState? actionState,
    Map<String, dynamic>? cartMap,
  }) {
    return PosState(
      cart: cart ?? this.cart,
      actionState: actionState ?? this.actionState,
      cartMap: cartMap ?? this.cartMap,
    );
  }
}
