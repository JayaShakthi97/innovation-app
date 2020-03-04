import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/utils/app_constant.dart';
import 'package:innovation_flutter_app/utils/route_util.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: Container(
        width: _width,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Hello, Shakthi.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppConstant.FONT_LARGE,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Looks like feel good.',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Expanded(child: Container()),
            PopupMenuButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                onSelected: (_) => RouteUtil.categoryPage(context),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem<int>(
                      value: 0,
                      child: Text("Manage Categories"),
                    ),
                    PopupMenuItem<int>(
                      value: 1,
                      child: Text("Google Signin"),
                    ),
                  ];
                }),
          ]),
        ),
      ),
    );
  }
}
