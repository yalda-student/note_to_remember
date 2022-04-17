class CategoryModel {
  final int id;
  final String title;
  int numberOfNotes;

  CategoryModel(
      {required this.id, required this.title, this.numberOfNotes = 0});

  @override
  String toString() {
    return 'CategoryModel{id: $id, title: $title, numberOfNotes: $numberOfNotes}';
  }
}
