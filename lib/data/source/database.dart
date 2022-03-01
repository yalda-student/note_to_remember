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


  // Future<int> create(NoteCompanion noteCompanion)async {
  // 
  //   return await into(note).insert(noteCompanion);
  // }