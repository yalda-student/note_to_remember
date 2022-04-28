import 'package:drift/drift.dart';
import 'package:yalda_students_notes/core/data/config/hive/hiveConfig.dart';
import 'package:yalda_students_notes/core/data/config/sqlite3/drift_config.dart';

import '../../util/pref_helper.dart';
import '../datasource/local/sqlite3_db.dart';

class NoteRepository {

  NoteRepository();

  Future<int> addNote(NoteCompanion noteCompanion) {
    if(PrefHelper.getIsWeb() ?? false){
      //fetch from hive
      HiveConfig.hiveDb.addNote(noteCompanion);
    }else{
      //fetch from sqlite3
      DriftConfig.appDatabase.addNote(noteCompanion);
    }
    throw UnimplementedError();
  }

  Future deleteNote(int id, int? categoryId) async {
    if(PrefHelper.getIsWeb() ?? false){
      //fetch from hive
      HiveConfig.hiveDb.deleteNote(id, categoryId!);
    }else{
      //fetch from sqlite3
      DriftConfig.appDatabase.deleteNote(id);
    }
    throw UnimplementedError();
  }

  Future updateNote(NoteData noteData) {
    if(PrefHelper.getIsWeb() ?? false){
      //fetch from hive
      HiveConfig.hiveDb.updateNote(noteData);
    }else{
      //fetch from sqlite3
      DriftConfig.appDatabase.updateNote(noteData);
    }
    throw UnimplementedError();
  }

  Future<NoteData> getNoteById(int id) async {
    if(PrefHelper.getIsWeb() ?? false){
      //fetch from hive
      HiveConfig.hiveDb.getNoteById(id);
    }else{
      //fetch from sqlite3
      DriftConfig.appDatabase.getNoteById(id);
    }
    throw UnimplementedError();
  }

  Stream<List<TypedResult>> getAllNotes({String keyword = ''}) {
    if(PrefHelper.getIsWeb() ?? false){
      //fetch from hive
      HiveConfig.hiveDb.getAllNotes();
    }else{
      //fetch from sqlite3
      DriftConfig.appDatabase.getAllNotes();
    }
    throw UnimplementedError();
  }

  Stream<List<TypedResult>> getStarNotes() {
    if(PrefHelper.getIsWeb() ?? false){
      //fetch from hive
      HiveConfig.hiveDb.getStarNotes();
    }else{
      //fetch from sqlite3
      DriftConfig.appDatabase.getStarNotes();
    }
    throw UnimplementedError();
  }

  Future<List<NoteData>> getNotesInCategory(int categoryId) async {
    if(PrefHelper.getIsWeb() ?? false){
      //fetch from hive
      HiveConfig.hiveDb.getNotesInCategory(categoryId);
    }else{
      //fetch from sqlite3
      DriftConfig.appDatabase.getNotesInCategory(categoryId);
    }
    throw UnimplementedError();
  }

  Future<void> addCategory(CategoryCompanion categoryCompanion) async {
    if(PrefHelper.getIsWeb() ?? false){
      //fetch from hive
      HiveConfig.hiveDb.addCategory(categoryCompanion);
    }else{
      //fetch from sqlite3
      DriftConfig.appDatabase.addCategory(categoryCompanion);
    }
    throw UnimplementedError();
  }

  Future deleteCategory(int categoryId) async {
    if(PrefHelper.getIsWeb() ?? false){
      //fetch from hive
      HiveConfig.hiveDb.deleteCategory(categoryId);
    }else{
      //fetch from sqlite3
      DriftConfig.appDatabase.deleteCategory(categoryId);
    }
    throw UnimplementedError();
  }

  Future<void> updateCategory(CategoryData categoryData) async {
    if(PrefHelper.getIsWeb() ?? false){
      //fetch from hive
      HiveConfig.hiveDb.updateCategory(categoryData);
    }else{
      //fetch from sqlite3
      DriftConfig.appDatabase.updateCategory(categoryData);
    }
    throw UnimplementedError();
  }

  Stream<List<TypedResult>> getAllCategories() {
    if(PrefHelper.getIsWeb() ?? false){
      //fetch from hive
      HiveConfig.hiveDb.getAllCategories();
    }else{
      //fetch from sqlite3
      DriftConfig.appDatabase.getAllCategories();
    }
    throw UnimplementedError();
  }

  Future<String> getCategoryTitle(int categoryId) {
    if(PrefHelper.getIsWeb() ?? false){
      //fetch from hive
      HiveConfig.hiveDb.getCategoryTitle(categoryId);
    }else{
      //fetch from sqlite3
      DriftConfig.appDatabase.getCategoryTitle(categoryId);
    }
    throw UnimplementedError();
  }


}
