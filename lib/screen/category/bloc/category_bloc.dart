import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/data/model/category_model.dart';
import 'package:yalda_students_notes/data/source/database.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final AppDatabase database;

  CategoryBloc(this.database) : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      if (event is CategoryDelete) {
        await database.deleteCategory(event.categoryId);
      }
      if (event is CategoryStart) {

        final categoryList = await database.getAllCategories();

        emit(CategorySuccess(categoryList));
      }
    });
  }
}
