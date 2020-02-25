import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/bloc/editTaskBloc.dart';
import 'package:innovation_flutter_app/models/category.dart';
import 'package:innovation_flutter_app/models/task.dart';
import 'package:innovation_flutter_app/pages/categoryFullView/dayTaskList.dart';
import 'package:innovation_flutter_app/utils/app_constant.dart';
import 'package:innovation_flutter_app/utils/route_util.dart';
import 'package:innovation_flutter_app/widgets/bodyContainer.dart';
import 'package:innovation_flutter_app/widgets/categoryIcon.dart';
import 'package:provider/provider.dart';

class CategoryFullViewPage extends StatefulWidget {
  final Category category;
  final String day;

  const CategoryFullViewPage({Key key, this.category, this.day})
      : super(key: key);

  @override
  _CategoryFullViewPageState createState() => _CategoryFullViewPageState();
}

class _CategoryFullViewPageState extends State<CategoryFullViewPage> {
  List<Task> todays = [];
  List<Task> tomorrows = [];
  List<Task> upcomings = [];

  @override
  void initState() {
    todays = [
      Task(title: 'Task One', comment: 'Comment one', done: false),
      Task(title: 'Task Two', done: true),
      Task(title: 'Task Three', done: false)
    ];
    tomorrows = [
      /*Task(title: 'Task Four', done: true),
      Task(title: 'Task Five', done: true),
      Task(title: 'Task Six', done: false)*/
    ];
    upcomings = [
      Task(title: 'Task Seven', done: false),
      Task(title: 'Task Eight', done: true),
      Task(title: 'Task Nine', done: false),
      Task(title: 'Task Seven', done: false),
      Task(title: 'Task Eight', done: true),
      Task(title: 'Task Nine', done: false),
      Task(title: 'Task Seven', done: false),
      Task(title: 'Task Eight', done: true),
      Task(title: 'Task Nine', done: false),
      Task(title: 'Task Seven', done: false),
      Task(title: 'Task Eight', done: true),
      Task(title: 'Task Nine', done: false),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyContainer(
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            Hero(
              tag: this.widget.category.title + this.widget.day,
              child: CategoryIcon(
                icon: this.widget.category.icon,
                color: this.widget.category.color,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Hero(
                tag: this.widget.category.title + this.widget.day + 'title',
                child: Container(
                  child: Text(
                    this.widget.category.title,
                    style: TextStyle(
                      fontSize: AppConstant.FONT_LARGE,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ]),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
              child: ListView(children: <Widget>[
                Container(
                  child: this.todays.length > 0
                      ? DayTaskList(
                          day: 'Today',
                          taskList: this.todays,
                        )
                      : null,
                ),
                Container(
                  child: this.tomorrows.length > 0
                      ? DayTaskList(
                          day: 'Tomorrow',
                          taskList: this.tomorrows,
                        )
                      : null,
                ),
                Container(
                  child: this.upcomings.length > 0
                      ? DayTaskList(
                          day: 'Upcoming',
                          taskList: this.upcomings,
                        )
                      : null,
                ),
              ]),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'createBtn',
        onPressed: () {
          Provider.of<EditTaskBloc>(context, listen: false).selectTask(Task());
          RouteUtil.createTaskPage(context);
        },
        label: Text('Add Task'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
