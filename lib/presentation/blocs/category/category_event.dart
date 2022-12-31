part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class OnFetchAllCategoryEvent extends CategoryEvent {}

class OnInsertUpdateCategoryEvent extends CategoryEvent {
  final Category category;
  final bool isUpdate;

  const OnInsertUpdateCategoryEvent({
    required this.category,
    required this.isUpdate,
  });

  @override
  List<Object> get props => [category];
}

class OnRemoveCategoryEvent extends CategoryEvent {
  final int id;

  const OnRemoveCategoryEvent(this.id);

  @override
  List<Object> get props => [id];
}
