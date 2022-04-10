class CategoryModel {
  final int id;
  final String title;
  final int numberOfNotes;

  CategoryModel({required this.id, required this.title, required this.numberOfNotes});

  @override
  String toString() {
    return 'CategoryModel{id: $id, title: $title, numberOfNotes: $numberOfNotes}';
  }
}
