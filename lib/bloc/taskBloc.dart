import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/models/task.dart';
import 'package:innovation_flutter_app/repository/taskRepository.dart';

class TaskBloc extends ChangeNotifier {
  final TaskRepository _taskRepository = TaskRepository();

  List<Task> _taskList = [];
  List<Task> _todayList = [];
  List<Task> _tomorrowList = [];
  List<Task> _upcomingList = [];

  bool _loading = true;

  List<Task> get tasksList => _taskList;

  List<Task> get todayTasksList => _todayList;

  List<Task> get tomorrowTasksList => _tomorrowList;

  List<Task> get upcomingTasksList => _upcomingList;

  bool get isLoading => _loading;

  getAllTasks() async {
    this._taskList = await this._taskRepository.getTasks(0);
    this.loading = false;
  }

  getTasks() {
    this.getTodayTasks();
    this.getTomorrowTasks();
    this.getUpcomingTasks();
  }

  getTodayTasks() async {
    this._todayList = await this._taskRepository.getTasks(1);
    notifyListeners();
    this.loading = false;
  }

  getTomorrowTasks() async {
    this._tomorrowList = await this._taskRepository.getTasks(2);
    notifyListeners();
    this.loading = false;
  }

  getUpcomingTasks() async {
    this._upcomingList = await this._taskRepository.getTasks(3);
    notifyListeners();
    this.loading = false;
  }

  set loading(bool value) {
    this._loading = value;
    notifyListeners();
  }
}
