import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:yalda_students_notes/core/data/config/sqlite3/drift_config.dart';

import '../../config/sqlite3/table/category_data.dart';
import '../../config/sqlite3/table/note_data.dart';
import '../../model/category_model.dart';
import '../../model/note_model.dart';

part 'sqlite3_db.g.dart';

@DriftDatabase(tables: [Note, Category])
class AppDatabase extends _$AppDatabase with ChangeNotifier {
  static final AppDatabase _instance = AppDatabase._internal();

  factory AppDatabase() {
    return _instance;
  }

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

  Future<bool> addNote(NoteCompanion noteCompanion) async {
    try {
      await into(note).insert(noteCompanion);
      return Future.value(true);
    } catch (e) {
      debugPrint(e.toString());
      return Future.value(true);
    }
  }

  Future deleteNote(int id) async {
    await (delete(note)..where((tbl) => tbl.id.equals(id))).go();
    notifyListeners();
  }

  Future updateNote(NoteData noteData) async {
    await update(note).replace(noteData);
    notifyListeners();
  }

  Future<NoteData> getNoteById(int id) {
    return (select(note)
          ..where((tbl) {
            return tbl.id.equals(id);
          }))
        .getSingle();
  }

  Future<List<NoteModel>> getAllNotes({String keyword = ''}) async {
    final query = (select(note)
          ..where((tbl) {
            return tbl.title.like('%$keyword%') |
                tbl.content.like('%$keyword%');
          }))
        .join([
      innerJoin(category, note.categoryId.equalsExp(category.id),
          useColumns: true)
    ]);

    final categories = <NoteModel>[];
    for (final row in await query.watch().first) {
      var noteData = row.readTable(DriftConfig.appDatabase.note);
      var categoryData = row.readTable(DriftConfig.appDatabase.category);

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

  Future<List<NoteModel>> getStarNotes() async {
    final query = (select(note)..where((tbl) => tbl.isFavorite.equals(true)))
        .join([
      innerJoin(category, note.categoryId.equalsExp(category.id),
          useColumns: true)
    ]);

    final categories = <NoteModel>[];
    for (final row in await query.watch().first) {
      var noteData = row.readTable(DriftConfig.appDatabase.note);
      var categoryData = row.readTable(DriftConfig.appDatabase.category);

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

  Future<List<NoteData>> getNotesInCategory(int categoryId) async {
    return await (select(note)
          ..where((tbl) => tbl.categoryId.equals(categoryId)))
        .get();
  }

  //-------------Category

  Future<void> addCategory(CategoryCompanion categoryCompanion) async {
    await into(category).insert(categoryCompanion);
    notifyListeners();
  }

  Future deleteCategory(int categoryId) async {
    await (delete(category)..where((tbl) => tbl.id.equals(categoryId))).go();
    notifyListeners();
  }

  Future<void> updateCategory(CategoryData categoryData) async {
    await update(category).replace(categoryData);
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

    final categories = <CategoryModel>[];
    for (final row in await query.watch().first) {
      var categoryData = row.readTable(DriftConfig.appDatabase.category);
      final model = CategoryModel(
          id: categoryData.id,
          title: categoryData.title,
          numberOfNotes: row.read(numberOfNotes));
      categories.add(model);
    }
    return categories;
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
