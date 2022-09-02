import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/app/app.dart';
import 'package:yalda_students_notes/data/datasource/table/category_data.dart';
import 'package:yalda_students_notes/data/datasource/table/note_data.dart';
import 'package:yalda_students_notes/data/mapper/mapper.dart';
import 'package:yalda_students_notes/domain/model/category_model.dart';
import 'package:yalda_students_notes/domain/model/note_model.dart';

import 'connection/connection.dart' as impl;

part 'database.g.dart';

@DriftDatabase(tables: [Note, Category])
class AppDatabase extends _$AppDatabase with ChangeNotifier, FetchData {
  static final AppDatabase _instance = AppDatabase._internal();

  factory AppDatabase() => _instance;

  AppDatabase._internal() : super(impl.connect().executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
        beforeOpen: (details) async =>
            await customStatement('PRAGMA foreign_keys = ON'),
        onCreate: (m) async {
          await m.createAll();
          into(category).insert(CategoryCompanion(
              title: const Value('None'),
              color: Value(generateColor()),
              createdAt: Value(DateTime.now())));
        });
  }

  //-------------Note

  Future<int> insertNote(NoteModel noteData) async {
    // return note.insertOne(NoteCompanion.insert(
    //     content: noteData.content,
    //     title: Value(noteData.title ?? ''),
    //     createdAt: noteData.createdAt,
    //     color: noteData.color));
    final id = await into(note).insert(noteData.toNoteCompanion());
    notifyListeners();
    return id;
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
    final data = await query.get();
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
    final categoryList = fetchCategoryData(this, data, note.id.count());

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
