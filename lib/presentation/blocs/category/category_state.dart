part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryFailure extends CategoryState {
  final String message;

  const CategoryFailure(this.message);

  @override
  List<Object> get props => [message];
}

class CategoryEmpty extends CategoryState {}

class CategoryActionSuccess extends CategoryState {
  final String message;

  const CategoryActionSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class CategoryActionFailure extends CategoryState {
  final String message;

  const CategoryActionFailure(this.message);

  @override
  List<Object> get props => [message];
}

class FetchAllCategorySuccess extends CategoryState {
  final List<Category> listCategory;

  const FetchAllCategorySuccess(this.listCategory);

  @override
  List<Object> get props => [listCategory];
}
