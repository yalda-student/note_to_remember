import 'package:drift/drift.dart';
import 'package:yalda_students_notes/model/category_data.dart';

class Note extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 6, max: 32)();
  TextColumn get content => text().named('body').nullable()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get color => integer()();
  IntColumn get priority => integer()();
  IntColumn get category => integer()
      .nullable()
      .withDefault(const Constant(1))
      .references(Category, #id,
          onDelete: KeyAction.setDefault, onUpdate: KeyAction.cascade)();
}
