import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/utils/route_util.dart';
import 'package:innovation_flutter_app/widgets/bodyContainer.dart';
import 'package:innovation_flutter_app/widgets/categoryIcon.dart';
import 'package:innovation_flutter_app/widgets/pageHeader.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyContainer(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              PageHeader(title: "Active People", iconData: Icons.clear),
              Container(
                child: Column(
                  children: <Widget>[
                    ChatTile(name: "Amal"),
                    ChatTile(name: "Kamal"),
                    ChatTile(name: "Nayani"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final String name;

  const ChatTile({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RouteUtil.personPage(context, name);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            CategoryIcon(
              icon: Icons.person,
              color: Colors.blue,
              size: 8.0,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(name)),
          ],
        ),
      ),
    );
  }
}
