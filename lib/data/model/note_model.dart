import 'package:drift/drift.dart';
import 'package:yalda_students_notes/data/datasource/drift/database.dart';

class NoteModel {
  final int id;
  final String? title;
  final String content;
  final DateTime createdAt;
  final int color;
  final bool isFavorite;
  int categoryId;
  String category;

  NoteModel(
      {this.id = -1,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.color,
      required this.isFavorite,
      this.categoryId = 1,
      this.category = 'None'});

  NoteModel.fromNoteData(NoteData noteData)
      : id = noteData.id,
        title = noteData.title,
        content = noteData.content,
        createdAt = noteData.createdAt,
        color = noteData.color,
        isFavorite = noteData.isFavorite,
        category = '',
        categoryId = noteData.categoryId ?? 1;

  NoteData toNoteDate() {
    return NoteData(
        id: id,
        title: title,
        content: content,
        createdAt: createdAt,
        color: color,
        categoryId: categoryId,
        isFavorite: isFavorite);
  }

  NoteCompanion toNoteCompanion() {
    return NoteCompanion(
      id: const Value.absent(),
      title: Value(title),
      content: Value(content),
      createdAt: Value(createdAt),
      color: Value(color),
      isFavorite: Value(isFavorite),
    );
  }

  @override
  String toString() {
    return 'NoteModel{id: $id, title: $title, content: $content, createdAt: $createdAt, color: $color, isFavorite: $isFavorite, categoryId: $categoryId, category: $category}';
  }
}
