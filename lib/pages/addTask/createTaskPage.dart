import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/models/category.dart';
import 'package:innovation_flutter_app/utils/app_constant.dart';
import 'package:innovation_flutter_app/widgets/bodyContainer.dart';
import 'package:innovation_flutter_app/widgets/colouredDivider.dart';

class CreateTaskPage extends StatelessWidget {
  final List<Category> slideList = [
    Category('Personal', Icons.person, Colors.blue),
    Category('Work', Icons.work, Colors.blue),
    Category('Academic', Icons.school, Colors.blue),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyContainer(
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => Navigator.pop(context),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'New Task',
                style: TextStyle(
                  fontSize: AppConstant.FONT_LARGE,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ]),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
              child: ListView(children: <Widget>[
                ColouredDivider(),
                TextFormField(
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
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: this.slideList.length,
                      itemBuilder: (context, index) {
                        return SelectCategoryCard(
                          category: slideList[index],
                        );
                      }),
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
        ]),
      ),
    );
  }
}

class SelectCategoryCard extends StatelessWidget {
  final Category category;

  const SelectCategoryCard({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        width: 120.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.black)),
        child: Center(
          child: Text(this.category.title),
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
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.black)),
          child: Center(
            child: Text(this.date),
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
