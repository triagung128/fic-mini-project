import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic_mini_project/common/enum_state.dart';
import 'package:fic_mini_project/domain/entity/cart.dart';
import 'package:fic_mini_project/domain/entity/product.dart';
import 'package:fic_mini_project/domain/usecases/cart/add_product_quantity.dart';
import 'package:fic_mini_project/domain/usecases/cart/add_product_to_cart.dart';
import 'package:fic_mini_project/domain/usecases/cart/clear_cart.dart';
import 'package:fic_mini_project/domain/usecases/cart/get_all_carts_map.dart';
import 'package:fic_mini_project/domain/usecases/cart/reduce_product_quantity.dart';

part 'pos_event.dart';
part 'pos_state.dart';

class PosBloc extends Bloc<PosEvent, PosState> {
  final AddProductToCart addProductToCart;
  final AddProductQuantity addProductQuantity;
  final ReduceProductQuantity reduceProductQuantity;
  final ClearCart clearCart;
  final GetAllCartsMap getAllCartsMap;

  PosBloc({
    required this.addProductToCart,
    required this.addProductQuantity,
    required this.reduceProductQuantity,
    required this.clearCart,
    required this.getAllCartsMap,
  }) : super(PosState.initial()) {
    on<OnClearCart>((event, emit) async {
      await clearCart.execute();
      emit(PosState.initial());
    });

    on<OnAddProductToCart>((event, emit) async {
      final result = await addProductToCart.execute(event.product);
      emit(
        state.copyWith(
          cart: result,
          actionState: PosActionState.noAction,
        ),
      );
    });

    on<OnAddProductQuantity>((event, emit) async {
      final result = await addProductQuantity.execute(event.product);
      emit(
        state.copyWith(
          cart: result,
          actionState: PosActionState.noAction,
        ),
      );
    });

    on<OnReduceProductQuantity>((event, emit) async {
      final result = await reduceProductQuantity.execute(event.product);
      emit(
        state.copyWith(
          cart: result,
          actionState: PosActionState.noAction,
        ),
      );
    });

    on<OnPosAction>((event, emit) async {
      final result = await getAllCartsMap.execute();
      if (result.containsValue(0)) {
        emit(
          state.copyWith(
            actionState: PosActionState.failed,
          ),
        );
      } else {
        emit(
          state.copyWith(
            actionState: PosActionState.success,
            cartMap: result,
          ),
        );
      }
    });
  }
}
