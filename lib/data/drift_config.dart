
import 'package:yalda_students_notes/data/datasource/database.dart';

class DriftConfig {
  static late AppDatabase appDatabase;

  static init() {
    appDatabase = AppDatabase();
  }
}
