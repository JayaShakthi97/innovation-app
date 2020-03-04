import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/bloc/categoryBloc.dart';
import 'package:innovation_flutter_app/bloc/editTaskBloc.dart';
import 'package:innovation_flutter_app/bloc/taskBloc.dart';
import 'package:innovation_flutter_app/models/category.dart';
import 'package:innovation_flutter_app/utils/app_constant.dart';
import 'package:innovation_flutter_app/utils/date_util.dart';
import 'package:innovation_flutter_app/widgets/bodyContainer.dart';
import 'package:innovation_flutter_app/widgets/colouredDivider.dart';
import 'package:innovation_flutter_app/widgets/pageHeader.dart';
import 'package:provider/provider.dart';

class CreateTaskPage extends StatelessWidget {
  final bool isUpdating;

  CreateTaskPage({Key key, this.isUpdating = false}) : super(key: key);

  final TextEditingController _titleText = TextEditingController();
  final TextEditingController _commentText = TextEditingController();
  final List<String> _days = ['Today', 'Tomorrow', 'Other'];

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
                        SelectDateCard(date: _days[0], index: 0),
                        SelectDateCard(date: _days[1], index: 1),
                        SelectDateCard(date: _days[2], index: 2),
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
                    child: CreateBtn(title: _titleText, comment: _commentText),
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
          Provider.of<EditTaskBloc>(context, listen: false)
              .changeSelectedCategory(category.id,
                  Provider.of<CategoryBloc>(context, listen: false).categories);
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

class SelectDateCard extends StatefulWidget {
  final String date;
  final int index;

  const SelectDateCard({Key key, this.date, this.index}) : super(key: key);

  @override
  _SelectDateCardState createState() => _SelectDateCardState();
}

class _SelectDateCardState extends State<SelectDateCard> {
  DateTime selectedDate;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: this.selectedDate ?? DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      Provider.of<EditTaskBloc>(context, listen: false).changeSelectedDay(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            if (widget.index > 1) {
              _selectDate(context);
            } else {
              Provider.of<EditTaskBloc>(context, listen: false)
                  .changeSelectedDay(this.widget.index);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                  width: 2.0,
                  color: Provider.of<EditTaskBloc>(context, listen: false)
                              .selectedTask
                              .selectedDayIndex ==
                          this.widget.index
                      ? AppConstant.APP_COLOR
                      : Colors.black),
            ),
            child: Center(
              child: Text(
                this.selectedDate == null
                    ? this.widget.date
                    : DateUtil.getFormattedDate(
                        this.selectedDate.millisecondsSinceEpoch),
                style: TextStyle(
                    color: Provider.of<EditTaskBloc>(context, listen: false)
                                .selectedTask
                                .selectedDayIndex ==
                            this.widget.index
                        ? AppConstant.APP_COLOR
                        : Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddReminderCard extends StatefulWidget {
  @override
  _AddReminderCardState createState() => _AddReminderCardState();
}

class _AddReminderCardState extends State<AddReminderCard> {
  TimeOfDay selectedTime;

  Future<void> _setReminder(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(initialTime: TimeOfDay.now(), context: context);
    if (picked != null && picked != selectedTime)
      Provider.of<EditTaskBloc>(context, listen: false)
          .changePickedTime(picked);
  }

  @override
  Widget build(BuildContext context) {
    selectedTime = Provider.of<EditTaskBloc>(context, listen: false)
        .selectedTask
        .pickedTime;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: InkWell(
        onTap: () => _setReminder(context),
        child: Row(children: <Widget>[
          Expanded(
            child: Container(
              child: Text(selectedTime == null ? 'Add Reminder' : 'Reminder'),
            ),
          ),
          Container(
            child: selectedTime == null
                ? Icon(Icons.alarm_off)
                : Text(selectedTime.format(context)),
          ),
        ]),
      ),
    );
  }
}

class CreateBtn extends StatelessWidget {
  final TextEditingController title;
  final TextEditingController comment;

  const CreateBtn({Key key, this.title, this.comment}) : super(key: key);

  void showSnackBar(BuildContext context, String msg) {
    final snackBar = SnackBar(content: Text(msg));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void createTask(BuildContext context) async {
    if (title.text == null || title.text == '') {
      showSnackBar(context, 'Title cannot be empty!');
      return;
    }
    int id = await Provider.of<EditTaskBloc>(context, listen: false)
        .createTask(title.text, comment.text);
    if (id > 0) {
      showSnackBar(context, 'Task Added.');
      Provider.of<TaskBloc>(context, listen: false).getTasks();
      Navigator.pop(context);
    } else {
      showSnackBar(context, 'Error Occured');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton.extended(
        heroTag: 'createBtn',
        onPressed: () => createTask(context),
        label: Text('Add Task'),
      ),
    );
  }
}
