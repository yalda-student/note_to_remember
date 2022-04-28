
import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 1)
class NoteModel extends HiveObject {
  @HiveField(0)
  late final int id;
  @HiveField(1)
  late final String? title;
  @HiveField(2)
  late final String content;
  @HiveField(3)
  late final DateTime createdAt;
  @HiveField(4)
  late final int color;
  @HiveField(5)
  late final bool isFavorite;
  @HiveField(6)
  late final int categoryId;
  @HiveField(7)
  late final String category;
  @HiveField(8)

  NoteModel(
      {required this.id,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.color,
      required this.isFavorite,
      required this.categoryId,
      required this.category}){
    id = id;
    title = title;
    content = content;
    createdAt = createdAt;
    color = color;
    isFavorite = isFavorite;
    categoryId = categoryId;
    category = category;
  }

  @override
  String toString() {
    return 'NoteModel{id: $id, title: $title, content: $content, createdAt: $createdAt, color: $color, isFavorite: $isFavorite, categoryId: $categoryId, category: $category}';
  }
}
