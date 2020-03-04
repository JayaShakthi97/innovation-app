import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/bloc/categoryBloc.dart';
import 'package:innovation_flutter_app/bloc/editTaskBloc.dart';
import 'package:innovation_flutter_app/models/task.dart';
import 'package:innovation_flutter_app/utils/app_constant.dart';
import 'package:innovation_flutter_app/utils/route_util.dart';
import 'package:innovation_flutter_app/utils/url_launcher.dart';
import 'package:provider/provider.dart';

class TaskListItem extends StatefulWidget {
  final Task task;

  const TaskListItem({Key key, this.task}) : super(key: key);

  @override
  _TaskListItemState createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  bool _isExpanded = false;
  bool _contact = false;
  bool _browse = false;

  @override
  void initState() {
    super.initState();
    if (widget.task.title.toLowerCase().contains("meet"))
      _contact = true;
    else if (widget.task.title.toLowerCase().contains("contact"))
      _contact = true;
    else if (widget.task.title.toLowerCase().contains("buy")) _browse = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 6.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Row(children: <Widget>[
              Text(
                widget.task.title,
                style: TextStyle(fontSize: AppConstant.FONT_MEDIUM),
              ),
            ]),
          ),
        ),
        Container(
          child: _isExpanded
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    widget.task.comment != null || widget.task.comment != ''
                        ? Text(
                            widget.task.comment,
                            style: TextStyle(color: Colors.grey),
                          )
                        : Container(),
                    Row(children: <Widget>[
                      Expanded(child: Container()),
                      _browse
                          ? IconButton(
                              icon: Icon(Icons.open_in_browser),
                              onPressed: () async {
                                bool res =
                                    await UrlLauncherUtil.launchGoogleSearch(
                                        '${widget.task.title} online');
                              })
                          : Container(),
                      _contact
                          ? IconButton(
                              icon: Icon(Icons.contact_mail),
                              onPressed: () async {
                                bool res = await UrlLauncherUtil.launchEmail(
                                    'example@gmail.com');
                              })
                          : Container(),
                      _contact
                          ? IconButton(
                              icon: Icon(Icons.contact_phone),
                              onPressed: () async {
                                bool res = await UrlLauncherUtil.launchPhone(
                                    '0710498767');
                              })
                          : Container(),
                      IconButton(
                          icon: Icon(Icons.done),
                          onPressed: () {
                            setState(() {
                              widget.task.done = true;
                            });
                          }),
                      IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Provider.of<EditTaskBloc>(context, listen: false)
                                .selectTask(
                                    widget.task,
                                    Provider.of<CategoryBloc>(context,
                                            listen: false)
                                        .categories);
                            RouteUtil.createTaskPage(context, updating: true);
                          }),
                    ]),
                  ],
                )
              : null,
        ),
      ]),
    );
  }
}
