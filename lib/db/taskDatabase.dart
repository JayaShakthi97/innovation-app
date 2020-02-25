import 'package:innovation_flutter_app/db/appDatabase.dart';
import 'package:innovation_flutter_app/models/task.dart';
import 'package:sqflite/sqflite.dart';

class TaskDatabase {
  static final TaskDatabase _taskDb = TaskDatabase._internal(AppDatabase.get());

  AppDatabase _appDatabase;

  //private internal constructor to make it singleton
  TaskDatabase._internal(this._appDatabase);

  static TaskDatabase get() {
    return _taskDb;
  }

  Future<List<Task>> getTasks() async {
    Database db = await _appDatabase.getDb();
    var result = await db.rawQuery("SELECT * FROM ${Task.tblTask}");
    return result.map((data) => Task.fromMap(data)).toList();
  }

  Future<int> insertTask(Task task) async {
    Database db = await _appDatabase.getDb();
    var result = db.insert(Task.tblTask, task.toMap());
    return result;
  }

  Future<int> updateTask(Task task) async {
    Database db = await _appDatabase.getDb();
    return db.update(Task.tblTask, task.toMap(),
        where: "${Task.dbId} = ?", whereArgs: [task.id]);
  }

  Future<int> deleteTask(int categoryId) async {
    Database db = await _appDatabase.getDb();
    return db.delete(Task.tblTask,
        where: "${Task.dbId} = ?", whereArgs: [categoryId]);
  }
}
