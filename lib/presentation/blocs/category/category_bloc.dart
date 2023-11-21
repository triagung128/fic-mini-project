import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic_mini_project/domain/entity/category.dart';
import 'package:fic_mini_project/domain/usecases/category/get_all_categories.dart';
import 'package:fic_mini_project/domain/usecases/category/insert_category.dart';
import 'package:fic_mini_project/domain/usecases/category/remove_category.dart';
import 'package:fic_mini_project/domain/usecases/category/update_category.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategories getAllCategories;
  final InsertCategory insertCategory;
  final UpdateCategory updateCategory;
  final RemoveCategory removeCategory;

  CategoryBloc({
    required this.getAllCategories,
    required this.insertCategory,
    required this.updateCategory,
    required this.removeCategory,
  }) : super(CategoryInitial()) {
    on<OnFetchAllCategories>((event, emit) async {
      emit(CategoryLoading());

      final result = await getAllCategories.execute();

      result.fold(
        (failure) => emit(CategoryFailure(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(CategoryEmpty());
          } else {
            emit(AllCategoriesLoaded(data));
          }
        },
      );
    });

    on<OnCreateCategory>((event, emit) async {
      emit(CategoryLoading());

      final result = await insertCategory.execute(event.category);

      result.fold(
        (failure) => emit(CategoryActionFailure(failure.message)),
        (successMessage) => emit(CategoryActionSuccess(successMessage)),
      );

      add(OnFetchAllCategories());
    });

    on<OnUpdateCategory>((event, emit) async {
      emit(CategoryLoading());

      final result = await updateCategory.execute(event.category);

      result.fold(
        (failure) => emit(CategoryActionFailure(failure.message)),
        (successMessage) => emit(CategoryActionSuccess(successMessage)),
      );

      add(OnFetchAllCategories());
    });

    on<OnDeleteCategory>((event, emit) async {
      emit(CategoryLoading());

      final result = await removeCategory.execute(event.category);

      result.fold(
        (failure) => emit(CategoryActionFailure(failure.message)),
        (successMessage) => emit(CategoryActionSuccess(successMessage)),
      );

      add(OnFetchAllCategories());
    });
  }
}
