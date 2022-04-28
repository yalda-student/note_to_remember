import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalda_students_notes/core/common/const.dart';
import 'package:yalda_students_notes/core/data/model/category_model.dart';
import 'package:yalda_students_notes/core/data/model/note_model.dart';
import 'package:yalda_students_notes/core/data/datasource/local/sqlite3_db.dart';

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
