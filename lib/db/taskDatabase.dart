import 'package:innovation_flutter_app/db/appDatabase.dart';

class TaskDatabase {
  static final TaskDatabase _taskDb = TaskDatabase._internal(AppDatabase.get());

  AppDatabase _appDatabase;

  //private internal constructor to make it singleton
  TaskDatabase._internal(this._appDatabase);

  static TaskDatabase get() {
    return _taskDb;
  }
}
