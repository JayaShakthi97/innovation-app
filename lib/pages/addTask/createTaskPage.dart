import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/bloc/categoryBloc.dart';
import 'package:innovation_flutter_app/bloc/editTaskBloc.dart';
import 'package:innovation_flutter_app/models/category.dart';
import 'package:innovation_flutter_app/utils/app_constant.dart';
import 'package:innovation_flutter_app/widgets/bodyContainer.dart';
import 'package:innovation_flutter_app/widgets/colouredDivider.dart';
import 'package:innovation_flutter_app/widgets/pageHeader.dart';
import 'package:provider/provider.dart';

class CreateTaskPage extends StatefulWidget {
  final bool isUpdating;

  CreateTaskPage({Key key, this.isUpdating = false}) : super(key: key);

  @override
  _CreateTaskPageState createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  TextEditingController _titleText = TextEditingController();
  TextEditingController _commentText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyContainer(
        child: Consumer<EditTaskBloc>(
          builder: (_, editTaskBloc, __) {
            _titleText.text = editTaskBloc.selectedTask.title;
            _commentText.text = editTaskBloc.selectedTask.comment;
            return Column(children: <Widget>[
              PageHeader(
                title: "New Task",
                iconData: Icons.clear,
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
                  child: ListView(children: <Widget>[
                    ColouredDivider(),
                    TextFormField(
                      controller: _titleText,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: "Title",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Title cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontFamily: "Poppins", fontSize: 20.0),
                    ),
                    ColouredDivider(),
                    TextFormField(
                      controller: _commentText,
                      maxLines: 8,
                      decoration: InputDecoration(
                        labelText: "Comment",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontFamily: "Poppins"),
                    ),
                    ColouredDivider(),
                    SizedBox(
                      height: 60.0,
                      child: Consumer<CategoryBloc>(
                        builder: (_, categoryBloc, __) => ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categoryBloc.categories.length,
                            itemBuilder: (context, index) {
                              return SelectCategoryCard(
                                index: index,
                                category: categoryBloc.categories[index],
                              );
                            }),
                      ),
                    ),
                    ColouredDivider(),
                    SizedBox(
                      height: 60.0,
                      child: Row(children: <Widget>[
                        SelectDateCard(date: 'Today'),
                        SelectDateCard(date: 'Tomorrow'),
                        SelectDateCard(date: 'Other'),
                      ]),
                    ),
                    ColouredDivider(),
                    SizedBox(
                      height: 60.0,
                      child: AddReminderCard(),
                    ),
                    ColouredDivider(),
                  ]),
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                  child: Container(
                    child: FloatingActionButton.extended(
                        heroTag: 'createBtn',
                        onPressed: () => print('tapped'),
                        label: Text('Add Task')),
                  ),
                ),
              ]),
            ]);
          },
        ),
      ),
    );
  }
}

class SelectCategoryCard extends StatelessWidget {
  final Category category;
  final int index;

  const SelectCategoryCard({Key key, this.category, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          print('Tapped');
          Provider.of<EditTaskBloc>(context, listen: false)
              .changeSelectedCategory(category.id);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          width: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
                width: 2.0,
                color: Provider.of<EditTaskBloc>(context, listen: false)
                            .selectedTask
                            .selectedCategoryIndex ==
                        index
                    ? AppConstant.APP_COLOR
                    : Colors.black),
          ),
          child: Center(
            child: Text(
              this.category.title,
              style: TextStyle(
                color: Provider.of<EditTaskBloc>(context, listen: false)
                            .selectedTask
                            .selectedCategoryIndex ==
                        index
                    ? AppConstant.APP_COLOR
                    : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectDateCard extends StatelessWidget {
  final String date;

  const SelectDateCard({Key key, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 2.0, color: Colors.black)),
            child: Center(
              child: Text(this.date),
            ),
          ),
        ),
      ),
    );
  }
}

class AddReminderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(children: <Widget>[
        Expanded(
          child: Container(
            child: Text('Add Reminder'),
          ),
        ),
        Container(
          child: Icon(Icons.alarm_off),
        ),
      ]),
    );
  }
}
