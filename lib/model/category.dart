import 'package:hive_flutter/adapters.dart';
part 'category.g.dart';

@HiveType(typeId: 1)
class Category {
  int id = -1;
  @HiveField(0)
  String name = '';
}
