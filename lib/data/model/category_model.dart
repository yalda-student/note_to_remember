import 'package:drift/drift.dart';
import 'package:yalda_students_notes/data/datasource/drift/database.dart';

class CategoryModel {
  final int id;
  final String title;
  int numberOfNotes;

  CategoryModel({
    this.id = -1,
    required this.title,
    this.numberOfNotes = 0,
  });

  CategoryCompanion toCategoryCompanion() {
    return CategoryCompanion(
      id: const Value.absent(),
      title: Value(title),
      createdAt: Value(DateTime.now()),
    );
  }

  CategoryData toCategoryData() {
    return CategoryData(
      id: id,
      title: title,
      createdAt: DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'CategoryModel{id: $id, title: $title, numberOfNotes: $numberOfNotes}';
  }
}
