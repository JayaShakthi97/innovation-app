import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/bloc/editTaskBloc.dart';
import 'package:innovation_flutter_app/models/task.dart';
import 'package:innovation_flutter_app/utils/route_util.dart';
import 'package:provider/provider.dart';

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
      Expanded(
        child: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Provider.of<EditTaskBloc>(context, listen: false)
                  .selectTask(widget.task);
              RouteUtil.createTaskPage(context, updating: true);
            }),
      ),
    ]);
  }
}
