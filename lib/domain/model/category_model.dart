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

  @override
  String toString() {
    return 'CategoryModel{id: $id, title: $title, color: $color, numberOfNotes: $numberOfNotes}';
  }
}
