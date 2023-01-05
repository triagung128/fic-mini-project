part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class OnFetchAllCategories extends CategoryEvent {}

class OnCreateCategory extends CategoryEvent {
  final Category category;

  const OnCreateCategory(this.category);

  @override
  List<Object> get props => [category];
}

class OnUpdateCategory extends CategoryEvent {
  final Category category;

  const OnUpdateCategory(this.category);

  @override
  List<Object> get props => [category];
}

class OnDeleteCategory extends CategoryEvent {
  final Category category;

  const OnDeleteCategory(this.category);

  @override
  List<Object> get props => [category];
}
