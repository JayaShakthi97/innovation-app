import 'package:innovation_flutter_app/db/categoryDatabase.dart';
import 'package:innovation_flutter_app/models/category.dart';

class CategoryRepository {
  final CategoryDatabase db = CategoryDatabase.get();

  Future<List<Category>> getCategories() => db.getCategories();

  Future<int> insertCategory(Category category) => db.insertCategory(category);
}
