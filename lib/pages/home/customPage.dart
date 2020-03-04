import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/bloc/taskBloc.dart';
import 'package:innovation_flutter_app/models/category.dart';
import 'package:innovation_flutter_app/models/task.dart';
import 'package:innovation_flutter_app/pages/categoryFullView/dayTaskList.dart';
import 'package:innovation_flutter_app/utils/app_constant.dart';
import 'package:innovation_flutter_app/widgets/categoryIcon.dart';
import 'package:innovation_flutter_app/widgets/doneIcon.dart';
import 'package:innovation_flutter_app/widgets/progressBar.dart';
import 'package:provider/provider.dart';

class CustomPage extends StatefulWidget {
  final Category category;
  final bool active;

  CustomPage({Key key, this.category, this.active}) : super(key: key);

  @override
  _CustomPageState createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  List<Task> taskList = [
    /*Task(title: 'Task One', done: false),
    Task(title: 'Task Two', done: true),
    Task(title: 'Task Three', done: false)*/
  ];

  int completed = 0;

  @override
  Widget build(BuildContext context) {
    completed = taskList.where((item) => item.done).length;
    final double blur = widget.active ? 20 : 0;
    final double offset = widget.active ? 10 : 0;
    final double top = widget.active ? 10 : 170;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 30, right: 30),
      padding: EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black87,
                blurRadius: blur,
                offset: Offset(offset, offset))
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: CategoryIcon(
                icon: this.widget.category.icon,
                color: this.widget.category.color,
              ),
            ),
            Container(
              child: Text(
                this.widget.category.title,
                style: TextStyle(
                  fontSize: AppConstant.FONT_LARGE,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        CategoryProgress(
            category: widget.category,
            total: this.taskList.length,
            completed: this.completed),
        Expanded(
          child: Container(
            child: ListView(children: <Widget>[
              Container(
                child: Consumer<TaskBloc>(
                  builder: (_, taskBloc, __) => DayTaskList(
                    day: 'Today',
                    taskList: taskBloc.todayTasksList
                        .where((task) => task.categoryId == widget.category.id)
                        .toList(),
                  ),
                ),
              ),
              Container(
                child: Consumer<TaskBloc>(
                  builder: (_, taskBloc, __) => DayTaskList(
                    day: 'Tomorrow',
                    taskList: taskBloc.tomorrowTasksList
                        .where((task) => task.categoryId == widget.category.id)
                        .toList(),
                  ),
                ),
              ),
              Container(
                child: Consumer<TaskBloc>(
                  builder: (_, taskBloc, __) => DayTaskList(
                    day: 'Upcoming',
                    taskList: taskBloc.upcomingTasksList
                        .where((task) => task.categoryId == widget.category.id)
                        .toList(),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
