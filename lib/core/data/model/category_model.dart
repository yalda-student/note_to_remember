import 'package:hive/hive.dart';

part 'category_model.g.dart';

@HiveType(typeId: 1)
class CategoryModel extends HiveObject {
  @HiveField(0)
  late final int id;
  @HiveField(1)
  late final String title;
  @HiveField(2)
  int numberOfNotes;

  CategoryModel(
      {required this.id,
        required this.title,
        this.numberOfNotes = 0}){
   id = id;
   title = title;
   numberOfNotes = numberOfNotes;
  }

  @override
  String toString() {
    return 'CategoryModel{id: $id, title: $title, numberOfNotes: $numberOfNotes}';
  }
}
