import 'package:yalda_students_notes/core/common/const.dart';
import 'package:yalda_students_notes/core/common/exception.dart';
import 'package:yalda_students_notes/data/datasource/drift/database.dart';
import 'package:yalda_students_notes/data/model/category_model.dart';

abstract class ICategoryRepository {
  Future insertCategory(CategoryModel category);

  Future<void> updateCategory(CategoryModel category);

  Future<void> deleteCategory(int id);

  Future<List<CategoryModel>> getAllCategories();

  Future<String> getCategoryTitle(int id);
}

class CategoryRepository implements ICategoryRepository {
  final AppDatabase datasource;

  CategoryRepository(this.datasource);

  @override
  Future insertCategory(CategoryModel category) {
    return datasource.addCategory(category);
  }

  @override
  Future<void> updateCategory(CategoryModel category) {
    return datasource.updateCategory(category);
  }

  @override
  Future<void> deleteCategory(int id) {
    return datasource.deleteCategory(id);
  }

  @override
  Future<List<CategoryModel>> getAllCategories() {
    return datasource.getAllCategories();
  }

  @override
  Future<String> getCategoryTitle(int id) {
    return datasource.getCategoryTitle(id);
  }
}
