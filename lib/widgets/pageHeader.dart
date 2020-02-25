import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/utils/app_constant.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final IconData iconData;

  const PageHeader({Key key, @required this.title, this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[
        IconButton(
          icon: Icon(this.iconData),
          onPressed: () => Navigator.pop(context),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            this.title,
            style: TextStyle(
              fontSize: AppConstant.FONT_LARGE,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ]),
    );
  }
}
