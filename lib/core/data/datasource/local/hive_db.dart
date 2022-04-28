import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:yalda_students_notes/core/data/datasource/local/sqlite3_db.dart';
import 'package:yalda_students_notes/core/data/model/category_model.dart';
import 'package:yalda_students_notes/core/data/model/note_model.dart';

import '../../config/hive/hiveConfig.dart';

class HiveDb {
  getKey(id) => (id.value ?? 0).toString();

  Future<bool> addNote(NoteCompanion noteCompanion) async {
    try {
      final box = await Hive.openBox(getKey(noteCompanion.categoryId));
      int id = DateTime.now().millisecondsSinceEpoch;
      await box.put(
          id,
          NoteModel(
              id: id,
              title: noteCompanion.title.value,
              content: noteCompanion.content.value,
              createdAt: noteCompanion.createdAt.value,
              color: noteCompanion.color.value,
              isFavorite: noteCompanion.isFavorite.value,
              categoryId: noteCompanion.categoryId.value,
              category:
                  await getCategoryTitle(noteCompanion.categoryId.value)));
      return Future.value(true);
    } catch (e) {
      debugPrint(e.toString());
      return Future.value(true);
    }
  }

  Future<bool> deleteNote(int id, int categoryId) async {
    try {
      final box = await Hive.openBox(getKey(categoryId));
      await box.delete(id);
      return Future.value(true);
    } catch (e) {
      debugPrint(e.toString());
      return Future.value(false);
    }
  }

  Future<bool> updateNote(NoteData noteData) async {
    try {
      final box = await Hive.openBox(getKey(noteData.categoryId));
      NoteModel editedData = NoteModel(
          id: noteData.id,
          title: noteData.title,
          content: noteData.content,
          createdAt: noteData.createdAt,
          color: noteData.color,
          isFavorite: noteData.isFavorite,
          categoryId: noteData.categoryId,
          category: await getCategoryTitle(noteData.categoryId));
      await box.put(noteData.id, editedData);

      return Future.value(true);
    } catch (e) {
      debugPrint(e.toString());
      return Future.value(false);
    }
  }

  Future<NoteData> getNoteById(int id) async {
    final catBox = await Hive.openBox(categoryBox);
    List<NoteData> result = <NoteData>[];
    for (var element in catBox.keys) {
      final box = await Hive.openBox(element);
      for (var note in box.values) {
        if(id == (note as NoteModel).id){
          result.add(NoteData(
              id: note.id,
              title: note.title,
              content: note.content,
              createdAt: note.createdAt,
              color: note.color,
              isFavorite: note.isFavorite,
              categoryId: note.categoryId));
        }
      }
    }
    return result[0];
  }

  Future<List<NoteModel>> getAllNotes({String keyword = ''}) async {
    final catBox = await Hive.openBox(categoryBox);
    List<NoteModel> result = <NoteModel>[];
    for (var element in catBox.keys) {
      final box = await Hive.openBox(element);
      for (var note in box.values) {
        result.add(note);
      }
    }
    return result;
  }

  Future<List<NoteModel>> getStarNotes() async {
    final box = await Hive.openBox(favoriteNoteBox);
    List<NoteModel> result = <NoteModel>[];
    for (var element in box.values) {
      result.add(element);
    }
    return result;
  }

  Future<List<NoteData>> getNotesInCategory(int categoryId) async {
    final box = await Hive.openBox(getKey(categoryId));
    List<NoteData> result = <NoteData>[];
    for (var element in box.values) {
      result.add(element);
    }
    return result;
  }

  Future<void> addCategory(CategoryCompanion categoryCompanion) async {
    final box = Hive.lazyBox(categoryBox);
    int categoryId = (categoryCompanion.createdAt.value.year.toString() +
        categoryCompanion.createdAt.value.month.toString() +
        categoryCompanion.createdAt.value.day.toString() +
        categoryCompanion.createdAt.value.hour.toString() +
        categoryCompanion.createdAt.value.minute.toString() +
        categoryCompanion.createdAt.value.second.toString() as int);
    box.put(categoryCompanion.createdAt,
        CategoryModel(id: categoryId, title: categoryCompanion.title.value));
  }

  Future<bool> deleteCategory(int categoryId) async {
    try {
      final box = Hive.lazyBox(categoryBox);
      box.delete(categoryId);
      return Future.value(true);
    } catch (e) {
      debugPrint(e.toString());
      return Future.value(false);
    }
  }

  Future<bool> updateCategory(CategoryData categoryData) async {
    try {
      final box = Hive.lazyBox(categoryBox);
      box.put(categoryData.id,
          CategoryModel(id: categoryData.id, title: categoryData.title));
      return Future.value(true);
    } catch (e) {
      debugPrint(e.toString());
      return Future.value(false);
    }
  }

  Future<List<CategoryModel>> getAllCategories() async {
    final box = await Hive.openBox(categoryBox);
    List<CategoryModel> result = <CategoryModel>[];
    for (var element in box.values) {
      result.add(element);
    }
    return Future.value(result);
  }

  Future<String> getCategoryTitle(int categoryId) async {
    final box = Hive.lazyBox(categoryBox);
    return Future.value((box.get(categoryId) as CategoryModel).title);
  }
}
