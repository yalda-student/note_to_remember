import 'package:yalda_students_notes/domain/model/category_model.dart';

abstract class ICategoryRepository {
  Future insertCategory(CategoryModel category);

  Future<void> updateCategory(CategoryModel category);

  Future<void> deleteCategory(int id);

  Future<List<CategoryModel>> getAllCategories();

  Future<String> getCategoryTitle(int id);
}