import 'package:innovation_flutter_app/db/appDatabase.dart';
import 'package:innovation_flutter_app/models/category.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDatabase {
  static final CategoryDatabase _taskDb =
      CategoryDatabase._internal(AppDatabase.get());

  AppDatabase _appDatabase;

  //private internal constructor to make it singleton
  CategoryDatabase._internal(this._appDatabase);

  static CategoryDatabase get() {
    return _taskDb;
  }

  Future<List<Category>> getCategories() async {
    Database db = await _appDatabase.getDb();
    var result = await db.rawQuery("SELECT * FROM ${Category.tblCategory}");
    return result.map((data) => Category.fromMap(data)).toList();
  }

  Future<int> insertCategory(Category category) async {
    Database db = await _appDatabase.getDb();
    var result = db.insert(Category.tblCategory, category.toMap());
    return result;
  }

  Future<int> updateCategory(Category category) async {
    Database db = await _appDatabase.getDb();
    return db.update(Category.tblCategory, category.toMap(),
        where: "${Category.dbId} = ?", whereArgs: [category.id]);
  }

  Future<int> deleteCategory(int categoryId) async {
    Database db = await _appDatabase.getDb();
    return db.delete(Category.tblCategory,
        where: "${Category.dbId} = ?", whereArgs: [categoryId]);
  }
}
