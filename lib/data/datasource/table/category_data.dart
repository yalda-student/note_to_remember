import 'package:drift/drift.dart';

class Category extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(max: 255)();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get color => integer()();

}
