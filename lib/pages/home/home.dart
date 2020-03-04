import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/bloc/categoryBloc.dart';
import 'package:innovation_flutter_app/bloc/editTaskBloc.dart';
import 'package:innovation_flutter_app/models/task.dart';
import 'package:innovation_flutter_app/pages/home/customPageView.dart';
import 'package:innovation_flutter_app/pages/home/header.dart';
import 'package:innovation_flutter_app/utils/route_util.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Header(),
          Expanded(
            child: CustomPageView(),
          ),
        ]),
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                RouteUtil.chatPage(context);
              },
              child: Icon(Icons.chat),
            ),
          ),
          Expanded(child: Container()),
          FloatingActionButton.extended(
            heroTag: 'createBtn',
            onPressed: () {
              Provider.of<EditTaskBloc>(context, listen: false).selectTask(
                  Task(dueAt: DateTime.now(), categoryId: 1),
                  Provider.of<CategoryBloc>(context, listen: false).categories);
              RouteUtil.createTaskPage(context);
            },
            label: Text('Add Task'),
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
