import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/models/task.dart';

class TaskListItem extends StatefulWidget {
  final Task task;

  const TaskListItem({Key key, this.task}) : super(key: key);

  @override
  _TaskListItemState createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  @override
  Widget build(BuildContext context) {
    TextDecoration td = widget.task.done ? TextDecoration.lineThrough : null;
    return Row(children: <Widget>[
      Checkbox(
          value: widget.task.done,
          onChanged: (val) {
            setState(() {
              widget.task.done = val;
            });
          }),
      Text(
        widget.task.title,
        style: TextStyle(decoration: td),
      ),
    ]);
  }
}
