import 'package:drift/drift.dart';

class Category extends Table {
  
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
}
