import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fic_mini_project/common/failure.dart';
import 'package:fic_mini_project/domain/entity/category.dart';
import 'package:fic_mini_project/domain/usecases/get_all_category.dart';
import 'package:fic_mini_project/domain/usecases/insert_category.dart';
import 'package:fic_mini_project/domain/usecases/remove_category.dart';
import 'package:fic_mini_project/domain/usecases/update_category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategory getAllCategory;
  final InsertCategory insertCategory;
  final UpdateCategory updateCategory;
  final RemoveCategory removeCategory;

  CategoryBloc({
    required this.getAllCategory,
    required this.insertCategory,
    required this.updateCategory,
    required this.removeCategory,
  }) : super(CategoryInitial()) {
    on<OnFetchAllCategoryEvent>((event, emit) async {
      emit(CategoryLoading());

      final result = await getAllCategory.execute();

      result.fold(
        (failure) => emit(CategoryFailure(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(CategoryEmpty());
          } else {
            emit(FetchAllCategorySuccess(data));
          }
        },
      );
    });

    on<OnInsertUpdateCategoryEvent>((event, emit) async {
      emit(CategoryLoading());

      late Either<Failure, String> result;

      if (!event.isUpdate) {
        result = await insertCategory.execute(event.category);
      } else {
        result = await updateCategory.execute(event.category);
      }

      result.fold(
        (failure) => emit(CategoryActionFailure(failure.message)),
        (successMessage) => emit(CategoryActionSuccess(successMessage)),
      );

      add(OnFetchAllCategoryEvent());
    });

    on<OnRemoveCategoryEvent>((event, emit) async {
      emit(CategoryLoading());

      final result = await removeCategory.execute(event.id);

      result.fold(
        (failure) => emit(CategoryActionFailure(failure.message)),
        (successMessage) => emit(CategoryActionSuccess(successMessage)),
      );

      add(OnFetchAllCategoryEvent());
    });
  }
}
