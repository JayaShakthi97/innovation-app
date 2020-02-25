import 'package:innovation_flutter_app/db/categoryDatabase.dart';
import 'package:innovation_flutter_app/models/category.dart';

class CategoryRepository {
  final CategoryDatabase db = CategoryDatabase.get();

  Future<List<Category>> getCategories() => db.getCategories();

  Future<int> insertCategory(Category category) => db.insertCategory(category);

  Future<int> updateCategory(Category category) => db.updateCategory(category);

  Future<int> deleteCategory(int id) => db.deleteCategory(id);
}
