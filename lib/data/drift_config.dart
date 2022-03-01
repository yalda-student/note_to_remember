import 'package:yalda_students_notes/data/source/database.dart';

class DriftConfig {
  static late AppDatabase appDatabase;

  static init() {
    appDatabase = AppDatabase();
  }
}
