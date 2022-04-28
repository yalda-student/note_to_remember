import 'package:yalda_students_notes/core/data/datasource/local/sqlite3_db.dart';

class DriftConfig {

  //lazy initialization
  static late AppDatabase? _db;
  static AppDatabase get appDatabase => _db ??= AppDatabase();
}
