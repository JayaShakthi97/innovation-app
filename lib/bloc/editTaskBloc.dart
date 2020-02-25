import 'package:innovation_flutter_app/bloc/categoryBloc.dart';
import 'package:innovation_flutter_app/models/task.dart';

class EditTaskBloc extends CategoryBloc {
  Task _selectedTask = Task();

  Task get selectedTask => this._selectedTask;

  void selectTask(Task task) {
    this._selectedTask = task;
    int cateIndex = this
        .categories
        .indexWhere((category) => category.id == task.categoryId);
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

  void changeSelectedCategory(int categoryId) {
    int cateIndex =
        this.categories.indexWhere((category) => category.id == categoryId);
    this.selectedTask.selectedCategoryIndex = cateIndex == -1 ? 0 : cateIndex;
    notifyListeners();
  }

  void clearSelected() {
    this._selectedTask = Task();
    notifyListeners();
  }
}
