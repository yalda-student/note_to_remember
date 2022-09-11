import 'package:yalda_students_notes/data/datasource/database.dart';

class NoteModel {
  int id;
  String title;
  String content;
  DateTime createdAt;
  int colorIndex;
  bool isFavorite;
  int categoryId;
  String category;

  NoteModel(
      {this.id = -1,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.colorIndex,
      required this.isFavorite,
      this.categoryId = 1,
      this.category = 'None'});

  NoteModel.fromNoteData(NoteData noteData)
      : id = noteData.id,
        title = noteData.title ?? '',
        content = noteData.content,
        createdAt = noteData.createdAt,
        colorIndex = noteData.colorIndex,
        isFavorite = noteData.isFavorite,
        category = '',
        categoryId = noteData.categoryId;

  @override
  String toString() {
    return 'NoteModel{id: $id, title: $title, content: $content, createdAt: $createdAt, color: $colorIndex, isFavorite: $isFavorite, categoryId: $categoryId, category: $category}';
  }
}
