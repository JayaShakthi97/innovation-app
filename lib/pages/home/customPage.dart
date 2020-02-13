import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/models/category.dart';
import 'package:innovation_flutter_app/models/task.dart';
import 'package:innovation_flutter_app/utils/app_constant.dart';
import 'package:innovation_flutter_app/widgets/categoryIcon.dart';
import 'package:innovation_flutter_app/widgets/doneIcon.dart';
import 'package:innovation_flutter_app/widgets/progressBar.dart';

class CustomPage extends StatefulWidget {
  final Category category;
  final String day;
  final bool active;
  final VoidCallback onPressed;

  CustomPage({Key key, this.category, this.active, this.onPressed, this.day})
      : super(key: key);

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

    return InkWell(
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 30, right: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black87,
                  blurRadius: blur,
                  offset: Offset(offset, offset))
            ]),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Hero(
                  tag: widget.category.title + widget.day,
                  child: CategoryIcon(
                    icon: this.widget.category.icon,
                    color: this.widget.category.color,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: this.taskList.length > 0 ? ListView.builder(
                      itemCount: this.taskList.length,
                      itemBuilder: (context, index) {
                        Task task = this.taskList[index];
                        TextDecoration td =
                            task.done ? TextDecoration.lineThrough : null;
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
                      }) : Center(
                    child: DoneIcon(),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Hero(
                        tag: widget.category.title + widget.day + 'title',
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
                      CategoryProgress(
                          category: widget.category,
                          total: this.taskList.length,
                          completed: this.completed),
                    ]),
              ),
            ]),
      ),
    );
  }
}
