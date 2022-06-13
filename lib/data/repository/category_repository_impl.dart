import 'package:yalda_students_notes/data/datasource/database.dart';
import 'package:yalda_students_notes/domain/model/category_model.dart';
import 'package:yalda_students_notes/domain/repository/category_repository.dart';

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
