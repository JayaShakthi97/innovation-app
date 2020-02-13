import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/models/task.dart';

class TaskList extends StatefulWidget {
  final List<Task> taskList;

  const TaskList({Key key, this.taskList}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.taskList.length,
        itemBuilder: (context, index) {
          Task task = widget.taskList[index];
          TextDecoration td = task.done ? TextDecoration.lineThrough : null;
          return Row(children: <Widget>[
            Checkbox(
                value: task.done,
                onChanged: (val) {
                  setState(() {
                    task.done = val;
                  });
                }),
            Text(
              task.title,
              style: TextStyle(decoration: td),
            ),
          ]);
        });
  }
}
