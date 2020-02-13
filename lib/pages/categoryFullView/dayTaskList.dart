import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/models/task.dart';
import 'package:innovation_flutter_app/utils/app_constant.dart';
import 'package:innovation_flutter_app/widgets/colouredDivider.dart';
import 'package:innovation_flutter_app/widgets/taskListItem.dart';

class DayTaskList extends StatelessWidget {
  final String day;
  final List<Task> taskList;

  const DayTaskList({Key key, this.day, this.taskList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ColouredDivider(),
      Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                this.day,
                style: TextStyle(
                  fontSize: AppConstant.FONT_MEDIUM,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Column(
                children: taskList.map((Task task) {
                  return TaskListItem(task: task);
                }).toList(),
              ),
            ]),
      ),
    ]);
  }
}
