part of 'pos_bloc.dart';

class PosState extends Equatable {
  final List<Cart> carts;
  final int total;

  const PosState({
    required this.carts,
    required this.total,
  });

  @override
  List<Object> get props => [carts, total];

  PosState copyWith({
    List<Cart>? carts,
    int? total,
  }) {
    return PosState(
      carts: carts ?? this.carts,
      total: total ?? this.total,
    );
  }

  factory PosState.initial() {
    return const PosState(
      carts: [],
      total: 0,
    );
  }
}
