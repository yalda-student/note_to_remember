import 'dart:math';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalda_students_notes/core/common/const.dart';
import 'package:yalda_students_notes/data/datasource/drift/database.dart';
import 'package:yalda_students_notes/data/model/category_model.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';

Future<bool> isFirstTime() async {
  final pref = await SharedPreferences.getInstance();
  var isFirstTime = pref.getBool(AppConstants.isFirstRun);
  if (isFirstTime != null && !isFirstTime) {
    pref.setBool('first_time', false);
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
        title: noteData.title,
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

  List<CategoryModel> fetchData(AppDatabase database, List<TypedResult> result,
      Expression<int> numberOfNotes) {
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

mixin ExtractCategoryData {
  CategoryModel extractCategoryData(String data) {
    final split = data.split(',');
    List values = [];
    for (int i = 0; i < split.length; i++) {
      values.add(split[i]);
    }

    int id = int.parse(values[0]!);
    values.removeAt(0);
    String title = values.join();

    return CategoryModel(id: id, title: title);
  }
}

Color generateColor() {
  return Color.fromRGBO(
    Random().nextInt(255),
    Random().nextInt(255),
    Random().nextInt(255),
    1,
  );
}
