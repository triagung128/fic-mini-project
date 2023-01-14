import 'package:equatable/equatable.dart';
import 'package:fic_mini_project/domain/entity/cart.dart';
import 'package:fic_mini_project/domain/entity/product.dart';
import 'package:fic_mini_project/domain/usecases/add_product_quantity.dart';
import 'package:fic_mini_project/domain/usecases/add_product_to_cart.dart';
import 'package:fic_mini_project/domain/usecases/clear_cart.dart';
import 'package:fic_mini_project/domain/usecases/get_total_price.dart';
import 'package:fic_mini_project/domain/usecases/reduce_product_quantity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pos_event.dart';
part 'pos_state.dart';

class PosBloc extends Bloc<PosEvent, PosState> {
  final AddProductToCart addProductToCart;
  final AddProductQuantity addProductQuantity;
  final ReduceProductQuantity reduceProductQuantity;
  final GetTotalPrice getTotalPrice;
  final ClearCart clearCart;

  PosBloc({
    required this.addProductToCart,
    required this.addProductQuantity,
    required this.reduceProductQuantity,
    required this.getTotalPrice,
    required this.clearCart,
  }) : super(PosState.initial()) {
    on<OnClearCart>((event, emit) async {
      await clearCart.execute();
      emit(PosState.initial());
    });

    on<OnAddProductToCart>((event, emit) async {
      final result = await addProductToCart.execute(event.product);
      final totalPrice = await getTotalPrice.execute();

      emit(
        state.copyWith(
          carts: result,
          total: totalPrice,
        ),
      );
    });

    on<OnAddProductQuantity>((event, emit) async {
      final result = await addProductQuantity.execute(event.product);
      final totalPrice = await getTotalPrice.execute();

      emit(
        state.copyWith(
          carts: result,
          total: totalPrice,
        ),
      );
    });

    on<OnReduceProductQuantity>((event, emit) async {
      final result = await reduceProductQuantity.execute(event.product);
      final totalPrice = await getTotalPrice.execute();

      emit(
        state.copyWith(
          carts: result,
          total: totalPrice,
        ),
      );
    });
  }
}
