class NoteModel {
  final int id;
  final String? title;
  final String content;
  final DateTime createdAt;
  final int color;
  final bool isFavorite;
  final int categoryId;
  final String category;

  NoteModel(
      {required this.id,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.color,
      required this.isFavorite,
      required this.categoryId,
      required this.category});

  @override
  String toString() {
    return 'NoteModel{id: $id, title: $title, content: $content, createdAt: $createdAt, color: $color, isFavorite: $isFavorite, categoryId: $categoryId, category: $category}';
  }
}
