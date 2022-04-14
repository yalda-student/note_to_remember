import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';
import 'package:yalda_students_notes/data/source/database.dart';

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
