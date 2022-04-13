import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:yalda_students_notes/data/table/category_data.dart';
import 'package:yalda_students_notes/data/table/note_data.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Note, Category])
class AppDatabase extends _$AppDatabase with ChangeNotifier {
  static final AppDatabase _instance = AppDatabase._internal();

  factory AppDatabase() {
    return _instance;
  }

  AppDatabase._internal() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  //-------------Note

  Future<int> addNote(NoteCompanion noteCompanion) async {
    return await into(note).insert(noteCompanion);
  }

  Future deleteNote(int id) async {
    await (delete(note)..where((tbl) => tbl.id.equals(id))).go();
    notifyListeners();
  }

  Future<void> updateNote(NoteData noteData) async {
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

  Stream<List<NoteData>> getAllNotes({String keyword = ''}) {
    return (select(note)
          ..where((tbl) {
            return tbl.title.like('%$keyword%') |
                tbl.content.like('%$keyword%');
          }))
        .watch();
  }

  Stream<List<NoteData>> getStarNotes() {
    return (select(note)
          ..where((tbl) {
            return tbl.isFavorite.equals(true);
          }))
        .watch();
  }

  Future<List<NoteData>> getNotesInCategory(categoryId) async {
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

  Stream<List<TypedResult>> getAllCategories() {
    final numberOfNotes = note.id.count();

    final query = select(category).join([
      leftOuterJoin(note, note.categoryId.equalsExp(category.id),
          useColumns: false)
    ])
      ..addColumns([numberOfNotes])
      ..groupBy([category.id, category.title]);
    // final result = await query.watch().first;
    // return _fetchData(result, numberOfNotes);

    return query.watch();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
