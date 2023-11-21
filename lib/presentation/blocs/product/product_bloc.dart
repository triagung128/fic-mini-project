import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic_mini_project/domain/entity/product.dart';
import 'package:fic_mini_project/domain/usecases/product/get_all_products.dart';
import 'package:fic_mini_project/domain/usecases/product/insert_product.dart';
import 'package:fic_mini_project/domain/usecases/product/remove_product.dart';
import 'package:fic_mini_project/domain/usecases/product/update_product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProducts getAllProducts;
  final InsertProduct insertProduct;
  final UpdateProduct updateProduct;
  final RemoveProduct removeProduct;

  ProductBloc({
    required this.getAllProducts,
    required this.insertProduct,
    required this.updateProduct,
    required this.removeProduct,
  }) : super(ProductInitial()) {
    on<OnFetchAllProducts>((_, emit) async {
      emit(ProductLoading());

      final result = await getAllProducts.execute();

      result.fold(
        (failure) => emit(ProductFailure(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(ProductEmpty());
          } else {
            emit(AllProductsLoaded(data));
          }
        },
      );
    });

    on<OnCreateProduct>((event, emit) async {
      emit(ProductLoading());

      final result = await insertProduct.execute(event.product);

      result.fold(
        (failure) => emit(ProductActionFailure(failure.message)),
        (successMessage) => emit(ProductActionSuccess(successMessage)),
      );

      add(OnFetchAllProducts());
    });

    on<OnUpdateProduct>((event, emit) async {
      emit(ProductLoading());

      final result = await updateProduct.execute(event.product);

      result.fold(
        (failure) => emit(ProductActionFailure(failure.message)),
        (successMessage) => emit(ProductActionSuccess(successMessage)),
      );

      add(OnFetchAllProducts());
    });

    on<OnDeleteProduct>((event, emit) async {
      emit(ProductLoading());

      final result = await removeProduct.execute(event.product);

      result.fold(
        (failure) => emit(ProductActionFailure(failure.message)),
        (successMessage) => emit(ProductActionSuccess(successMessage)),
      );

      add(OnFetchAllProducts());
    });
  }
}
