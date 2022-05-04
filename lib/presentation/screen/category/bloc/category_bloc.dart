import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yalda_students_notes/data/model/category_model.dart';
import 'package:yalda_students_notes/data/repository/category_repository.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repository;
  CategoryModel _category;

  CategoryBloc(this.repository, this._category) : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      if (event is CategoryStart) {
        final data = await repository.getAllCategories();
        emit(CategorySuccess(data));
      } else if (event is CategoryInsert) {
        repository.insertCategory(_category);
      }
      if (event is CategoryDelete) {
        await repository.deleteCategory(event.categoryId);
      } else if (event is CategoryTextFieldChange) {
        _category = CategoryModel(title: event.categoryName);
      }
    });
  }
}
