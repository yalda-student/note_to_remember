import 'package:drift/drift.dart';
import 'package:yalda_students_notes/data/datasource/database.dart';

class CategoryModel {
  final int id;
  final String title;
   int color;
  int numberOfNotes;

  CategoryModel({
    this.id = -1,
    required this.title,
    required this.color,
    this.numberOfNotes = 0,
  });

  CategoryCompanion toCategoryCompanion() {
    return CategoryCompanion(
      id: const Value.absent(),
      title: Value(title),
      createdAt: Value(DateTime.now()),
      color: Value(color)
    );
  }

  CategoryData toCategoryData() {
    return CategoryData(
      id: id,
      title: title,
      createdAt: DateTime.now(),
      color: color
    );
  }

  @override
  String toString() {
    return 'CategoryModel{id: $id, title: $title, color: $color, numberOfNotes: $numberOfNotes}';
  }
}
