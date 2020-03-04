import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/models/category.dart';
import 'package:innovation_flutter_app/models/task.dart';
import 'package:innovation_flutter_app/repository/taskRepository.dart';

class EditTaskBloc with ChangeNotifier {
  final TaskRepository _taskRepository = TaskRepository();

  Task _selectedTask = Task();

  Task get selectedTask => this._selectedTask;

  void selectTask(Task task, List<Category> categories) {
    this._selectedTask = task;
    int cateIndex =
        categories.indexWhere((category) => category.id == task.categoryId);
    task.selectedCategoryIndex = cateIndex == -1 ? 0 : cateIndex;

    DateTime today = DateTime.now();

    if (task.dueAt != null) {
      if (task.dueAt.isAfter(DateTime(today.year, today.month, today.day)) &&
          task.dueAt
              .isBefore(DateTime(today.year, today.month, today.day + 1))) {
        task.selectedDayIndex = 0;
      } else if (task.dueAt
              .isAfter(DateTime(today.year, today.month, today.day + 1)) &&
          task.dueAt
              .isBefore(DateTime(today.year, today.month, today.day + 2))) {
        task.selectedDayIndex = 1;
      } else {
        task.selectedDayIndex = 2;
      }
    } else {
      task.selectedDayIndex = 0;
    }
    notifyListeners();
  }

  void changeSelectedCategory(int categoryId, List<Category> categories) {
    int cateIndex =
        categories.indexWhere((category) => category.id == categoryId);
    this.selectedTask.selectedCategoryIndex = cateIndex == -1 ? 0 : cateIndex;
    this.selectedTask.categoryId = categoryId;
    notifyListeners();
  }

  void changeSelectedDay(int tapped, {DateTime date}) {
    if (tapped < 0 || tapped > 2) {
      this.selectedTask.selectedDayIndex = 0;
      this.selectedTask.dueAt = DateTime.now();
    } else {
      this.selectedTask.selectedDayIndex = tapped;
      if (tapped == 0)
        this.selectedTask.dueAt = DateTime.now();
      else if (tapped == 1)
        this.selectedTask.dueAt = DateTime.now().add(Duration(days: 1));
      else
        this.selectedTask.dueAt = date;
    }
    notifyListeners();
  }

  void changePickedTime(TimeOfDay time) {
    this.selectedTask.pickedTime = time;
    notifyListeners();
  }

  Future<int> createTask(String title, String comment) {
    _selectedTask.title = title;
    _selectedTask.comment = comment;
    DateTime dueAt = _selectedTask.dueAt;
    _selectedTask.dueAt = DateTime(dueAt.year, dueAt.month, dueAt.day);
    if (_selectedTask.pickedTime != null) {
      TimeOfDay remindAt = _selectedTask.pickedTime;
      _selectedTask.remindAt = DateTime(
          dueAt.year, dueAt.month, dueAt.day, remindAt.hour, remindAt.minute);
    }
    print(_selectedTask.toString());
    var id = _taskRepository.insertTask(this._selectedTask);
    notifyListeners();
    return id;
  }
}
