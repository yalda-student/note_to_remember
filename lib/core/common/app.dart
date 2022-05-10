import 'dart:math';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalda_students_notes/core/common/const.dart';
import 'package:yalda_students_notes/data/datasource/database.dart';
import 'package:yalda_students_notes/data/model/category_model.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';

Future<bool> isFirstTime() async {
  final pref = await SharedPreferences.getInstance();
  var isFirstTime = pref.getBool(AppConstants.isFirstRun);
  if (isFirstTime != null && !isFirstTime) {
    pref.setBool(AppConstants.isFirstRun, false);
    return false;
  } else {
    pref.setBool(AppConstants.isFirstRun, false);
    return true;
  }
}

mixin FetchData {
  List<NoteModel> fetchNoteData(
      AppDatabase database, List<TypedResult> result) {
    final categories = <NoteModel>[];
    for (final row in result) {
      var noteData = row.readTable(database.note);
      var categoryData = row.readTable(database.category);

      final model = NoteModel(
        id: noteData.id,
        title: noteData.title ?? '',
        content: noteData.content,
        createdAt: noteData.createdAt,
        color: noteData.color,
        isFavorite: noteData.isFavorite,
        categoryId: categoryData.id,
        category: categoryData.title,
      );
      categories.add(model);
    }
    return categories;
  }

  List<CategoryModel> fetchCategoryData(AppDatabase database,
      List<TypedResult> result, Expression<int> numberOfNotes) {
    final categories = <CategoryModel>[];
    for (final row in result) {
      var categoryData = row.readTable(database.category);
      final model = CategoryModel(
          id: categoryData.id,
          title: categoryData.title,
          color: categoryData.color,
          numberOfNotes: row.read(numberOfNotes));
      categories.add(model);
    }

    return categories;
  }
}

mixin ExtractCategoryData {
  CategoryModel extractCategoryData(String data) {
    debugPrint(data);
    final split = data.split(',');
    List values = [];
    for (int i = 0; i < split.length; i++) {
      values.add(split[i]);
    }

    int id = int.parse(values[0]!);
    int color = int.parse(values[1]!);
    values.removeRange(0,2);
    String title = values.join();

    return CategoryModel(
        id: id,
        title: title,
        color: color);
  }
}

int generateColor() {
  return Color.fromRGBO(
    Random().nextInt(255),
    Random().nextInt(255),
    Random().nextInt(255),
    1,
  ).value;
}
