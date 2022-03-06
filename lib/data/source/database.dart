import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:yalda_students_notes/model/category_data.dart';
import 'package:yalda_students_notes/model/note_data.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Note, Category])
class AppDatabase extends _$AppDatabase {
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
  }

  Future<bool> updateNote(NoteData noteData) async {
    return await update(note).replace(noteData);
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

  Future<int> addCategory(CategoryCompanion categoryCompanion) async {
    return await into(category).insert(categoryCompanion);
  }

  void deleteCategory(CategoryData categoryData) {
    return delete(category).where((tbl) => tbl.id.equals(categoryData.id));
  }

  Future<bool> updateCategory(CategoryData categoryData) async {
    return await update(category).replace(categoryData);
  }

  Future<List<CategoryData>> getAllCategories() async {
    return await select(category).get();
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
