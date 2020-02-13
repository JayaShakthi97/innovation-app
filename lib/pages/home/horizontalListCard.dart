import 'package:flutter/material.dart';

class HorizontalListCard extends StatelessWidget {
  final Icon icon;
  final String title;
  final int index;

  const HorizontalListCard({Key key, this.icon, this.title, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
          left: index == 0
              ? MediaQuery.of(context).size.width * 0.2
              : MediaQuery.of(context).size.width * 0.05),
      child: Container(
        width: _width * 0.65,
        child: Card(
          child: Column(
            children: <Widget>[
              this.icon,
              Column(
                children: <Widget>[],
              )
            ],
          ),
        ),
      ),
    );
  }
}
