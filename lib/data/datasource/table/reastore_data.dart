import 'package:drift/drift.dart';
import 'package:yalda_students_notes/data/datasource/table/category_data.dart';

class Note extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(max: 255).nullable()();
  TextColumn get content => text().named('body')();
  DateTimeColumn get deletedAt => dateTime()();
  IntColumn get color => integer()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  IntColumn get categoryId => integer()
      .nullable()
      .withDefault(const Constant(1))
      .references(Category, #id,
          onDelete: KeyAction.setDefault, onUpdate: KeyAction.cascade)();
}
