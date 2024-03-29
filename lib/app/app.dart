import 'dart:math';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/app/app_prefs.dart';
import 'package:yalda_students_notes/app/di.dart';
import 'package:yalda_students_notes/app/global.dart';
import 'package:yalda_students_notes/data/datasource/database.dart';
import 'package:yalda_students_notes/domain/model/category_model.dart';
import 'package:yalda_students_notes/domain/model/note_model.dart';

mixin FetchData {
  List<NoteModel> fetchNoteData(
      AppDatabase database, List<TypedResult> result) {
    final noteList = <NoteModel>[];
    for (final row in result) {
      var noteData = row.readTable(database.note);
      var categoryData = row.readTable(database.category);

      final model = NoteModel(
        id: noteData.id,
        title: noteData.title ?? '',
        content: noteData.content,
        createdAt: noteData.createdAt,
        colorIndex: noteData.colorIndex,
        isFavorite: noteData.isFavorite,
        categoryId: categoryData.id,
        category: categoryData.title,
      );
      noteList.add(model);
    }
    return noteList;
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
    values.removeRange(0, 2);
    String title = values.join();

    return CategoryModel(id: id, title: title, color: color);
  }
}

int generateColor() {
  return Color.fromRGBO(Random().nextInt(255), Random().nextInt(255),
          Random().nextInt(255), 1)
      .value;
}

bool isPersianLanguage() =>
    appLocale.languageCode == const Locale('fa', 'IR').languageCode;

Future<bool> isFirstTime() async {
  final appPref = instance<AppPreferences>();

  var isFirstTime = await appPref.isFirstRun();
  if (!isFirstTime) {
    return false;
  } else {
    appPref.setFirstRun(false);
    return true;
  }
}
