import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:yalda_students_notes/core/common/app.dart';
import 'package:yalda_students_notes/data/datasource/drift/table/category_data.dart';
import 'package:yalda_students_notes/data/datasource/drift/table/note_data.dart';
import 'package:yalda_students_notes/data/model/category_model.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Note, Category])
class AppDatabase extends _$AppDatabase with ChangeNotifier, FetchData {
  static final AppDatabase _instance = AppDatabase._internal();

  factory AppDatabase() => _instance;

  AppDatabase._internal() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    });
  }

  //-------------Note

  Future<int> addNote(NoteModel noteData) async {
    return await into(note).insert(noteData.toNoteCompanion());
  }

  Future deleteNote(int id) async {
    await (delete(note)..where((tbl) => tbl.id.equals(id))).go();
    notifyListeners();
  }

  Future updateNote(NoteModel noteData) async {
    await update(note).replace(noteData.toNoteDate());
    notifyListeners();
  }

  Future<NoteModel> getNoteById(int id) async {
    final noteData = await (select(note)
          ..where((tbl) {
            return tbl.id.equals(id);
          }))
        .getSingle();
    return NoteModel.fromNoteData(noteData);
  }

  Future<List<NoteModel>> getAllNotes(String keyword) async {
    final query = (select(note)
          ..where((tbl) {
            return tbl.title.like('%$keyword%') |
                tbl.content.like('%$keyword%');
          }))
        .join([
      innerJoin(category, note.categoryId.equalsExp(category.id),
          useColumns: true)
    ]);
    final data = await query.watch().first;
    return fetchNoteData(this, data);
  }

  Future<List<NoteModel>> getStarNotes() async {
    final query = (select(note)..where((tbl) => tbl.isFavorite.equals(true)))
        .join([
      innerJoin(category, note.categoryId.equalsExp(category.id),
          useColumns: true)
    ]);
    final data = await query.watch().first;
    return fetchNoteData(this, data);
  }

  Future<List<NoteModel>> getNotesInCategory(int categoryId) async {
    var data = await (select(note)
          ..where((tbl) => tbl.categoryId.equals(categoryId)))
        .get();
    final list = <NoteModel>[];
    for (var element in data) {
      list.add(NoteModel.fromNoteData(element));
    }

    return list;
  }

  //-------------Category

  Future<void> addCategory(CategoryModel categoryData) async {
    await into(category).insert(categoryData.toCategoryCompanion());
    notifyListeners();
  }

  Future deleteCategory(int categoryId) async {
    await (delete(category)..where((tbl) => tbl.id.equals(categoryId))).go();
    notifyListeners();
  }

  Future<void> updateCategory(CategoryModel categoryData) async {
    await update(category).replace(categoryData.toCategoryData());
    notifyListeners();
  }

  Future<List<CategoryModel>> getAllCategories() async {
    final numberOfNotes = note.id.count();

    final query = select(category).join([
      leftOuterJoin(note, note.categoryId.equalsExp(category.id),
          useColumns: false)
    ])
      ..addColumns([numberOfNotes])
      ..groupBy([category.id, category.title]);

    final data = await query.watch().first;
    final categoryList = fetchData(this, data, note.id.count());

    return categoryList;
  }

  Future<String> getCategoryTitle(int categoryId) {
    final query = select(category)
      ..where((tbl) {
        return tbl.id.equals(categoryId);
      });

    return query.map((row) => row.title).getSingle();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
