import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalda_students_notes/common/const.dart';
import 'package:yalda_students_notes/data/model/category_model.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';
import 'package:yalda_students_notes/data/source/database.dart';

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

mixin FetchNote {
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

List<Color> categoryColors = [
  Colors.yellow,
  Colors.deepPurple,
  Colors.cyan,
  Colors.orange,
  Colors.lightGreen,
  Colors.red,
  Colors.indigo,
  Colors.teal,
];
