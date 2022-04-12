import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/data/model/category_model.dart';
import 'package:yalda_students_notes/data/source/database.dart';

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
        // emit(CategoryLoading());
        database.addCategory(_category);
        add(CategoryStart());
      }
      if (event is CategoryDelete) {
        await database.deleteCategory(event.categoryId);
        add(CategoryStart());
        debugPrint('delete');
      } else if (event is CategoryTextFieldChange) {
        _category = CategoryCompanion(
            title: drift.Value(event.categoryName),
            createdAt: drift.Value(DateTime.now()));
      }
    });
  }

  Future<void> _initialList(Emitter<CategoryState> emit) async {
    final x = await database.getAllCategories().first;
    final categoryList = _fetchData(x, database.note.id.count());
    debugPrint(categoryList.length.toString());
    emit(CategorySuccess(categoryList));
  }

  List<CategoryModel> _fetchData(
      List<TypedResult> result, Expression<int> numberOfNotes) {
    final categories = <CategoryModel>[];
    for (final row in result) {
      var categoryData = row.readTable(database.category);
      final model = CategoryModel(
          id: categoryData.id,
          title: categoryData.title,
          numberOfNotes: row.read(numberOfNotes));
      categories.add(model);
    }

    return categories;
  }
}
