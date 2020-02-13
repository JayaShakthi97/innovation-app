import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/utils/app_constant.dart';

class DoneIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        Icons.done,
        size: 150,
        color: AppConstant.DONE_COLOR,
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
