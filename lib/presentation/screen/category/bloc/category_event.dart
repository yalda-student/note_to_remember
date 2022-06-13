part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class CategoryStart extends CategoryEvent {
  @override
  List<Object?> get props => [];
}

class CategoryTextFieldChange extends CategoryEvent {
  final String categoryName;

  const CategoryTextFieldChange(this.categoryName);

  @override
  List<Object?> get props => [];
}

class CategoryInsert extends CategoryEvent {
  @override
  List<Object?> get props => [];
}

class CategoryDelete extends CategoryEvent {
  final int categoryId;

  const CategoryDelete(this.categoryId);

  @override
  List<Object?> get props => [];
}
