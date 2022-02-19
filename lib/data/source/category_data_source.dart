import 'package:yalda_students_notes/data/source/source.dart';
import 'package:yalda_students_notes/model/category.dart';

class CategoryDataSource implements DataSource<Category> {

  @override
  Future<Category> createOrUpdate(Category data) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(Category data) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll() {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteById(id) {
    throw UnimplementedError();
  }

  @override
  Future<List<Category>> getData({String keyword = ''}) {
    throw UnimplementedError();
  }

}