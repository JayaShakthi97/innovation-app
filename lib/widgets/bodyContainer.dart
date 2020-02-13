import 'package:flutter/material.dart';

class BodyContainer extends StatelessWidget {
  final Widget child;

  const BodyContainer({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: this.child,
        ),
      ),
    );
  }
}
