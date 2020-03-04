import 'package:innovation_flutter_app/db/taskDatabase.dart';
import 'package:innovation_flutter_app/models/task.dart';

class TaskRepository{
  final TaskDatabase db = TaskDatabase.get();

  Future<List<Task>> getTasks(int day) => db.getTasks(day);

  Future<int> insertTask(Task task) => db.insertTask(task);

  Future<int> updateTask(Task task) => db.updateTask(task);

  Future<int> deleteTask(int id) => db.deleteTask(id);
}