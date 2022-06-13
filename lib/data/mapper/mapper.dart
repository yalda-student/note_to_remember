import 'package:drift/drift.dart';
import 'package:yalda_students_notes/data/datasource/database.dart';
import 'package:yalda_students_notes/domain/model/category_model.dart';
import 'package:yalda_students_notes/domain/model/note_model.dart';

extension CategoryModelMapper on CategoryModel {
  CategoryCompanion toCategoryCompanion() {
    return CategoryCompanion(
        id: const Value.absent(),
        title: Value(title),
        createdAt: Value(DateTime.now()),
        color: Value(color));
  }

  CategoryData toCategoryData() {
    return CategoryData(
        id: id, title: title, createdAt: DateTime.now(), color: color);
  }
}

extension NoteModelMapper on NoteModel {
  NoteData toNoteDate() {
    return NoteData(
        id: id,
        title: title,
        content: content,
        createdAt: createdAt,
        colorIndex: colorIndex,
        categoryId: categoryId,
        isFavorite: isFavorite);
  }

  NoteCompanion toNoteCompanion() {
    return NoteCompanion(
      id: const Value.absent(),
      title: Value(title),
      content: Value(content),
      createdAt: Value(createdAt),
      colorIndex: Value(colorIndex),
      isFavorite: Value(isFavorite),
    );
  }
}
