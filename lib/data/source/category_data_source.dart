import 'package:yalda_students_notes/data/source/source.dart';
import 'package:yalda_students_notes/model/category_data.dart';

class CategoryDataSource implements DataSource<Category> {


  @override
  Future<int> create(Category data) {
    throw UnimplementedError();
  }

  @override
  Future<Category> update(Category data) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(id) {
    throw UnimplementedError();
  }

  @override
  Future<List<Category>> getData({String keyword = ''}) {
    throw UnimplementedError();
  }


}