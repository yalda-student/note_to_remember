import 'package:hive_flutter/adapters.dart';
part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  int id = -1;
  @HiveField(0)
  String title = '';
  @HiveField(1)
  String content = '';
  @HiveField(2)
  bool isFavorite = false;
  @HiveField(3)
  int categoryId = 1;
}
