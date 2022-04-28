import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:drift/drift.dart' as drift;
import 'package:yalda_students_notes/core/data/model/category_model.dart';
import 'package:yalda_students_notes/core/data/datasource/local/sqlite3_db.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final AppDatabase database;
  CategoryCompanion _category;

  CategoryBloc(this.database, this._category) : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      if (event is CategoryStart) {
        await _initialList(emit);
      } else if (event is CategoryInsert) {
        database.addCategory(_category);
      }
      if (event is CategoryDelete) {
        await database.deleteCategory(event.categoryId);
      } else if (event is CategoryTextFieldChange) {
        _category = CategoryCompanion(
            title: drift.Value(event.categoryName),
            createdAt: drift.Value(DateTime.now()));
      }
    });
  }

  Future<void> _initialList(Emitter<CategoryState> emit) async {
    database.getAllCategories().then((value) {
      emit(CategorySuccess(value));
    });
  }
}
