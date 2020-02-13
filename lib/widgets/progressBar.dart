import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/models/category.dart';

class CategoryProgress extends StatelessWidget {
  final Category category;
  final int total;
  final int completed;

  const CategoryProgress({Key key, this.category, this.total, this.completed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProgressAnimation(
      value: _calclulateProgress(),
      builder: (context, progress) => Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 3.0,
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.black12,
                valueColor: AlwaysStoppedAnimation(category.color),
              ),
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Text(
            "${(progress * 100).toInt()}%",
            style: Theme.of(context).textTheme.subhead,
          ),
        ],
      ),
    );
  }

  double _calclulateProgress() {
    if (this.completed == 0) {
      return 0.0;
    }
    return completed.toDouble() / total;
  }
}

class ProgressAnimation extends StatefulWidget {
  final double value;
  final ProgressBuilder builder;

  const ProgressAnimation({Key key, this.value, this.builder})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProgressState();
}

class _ProgressState extends State<ProgressAnimation>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> _valueTween;
  double _value;

  @override
  void initState() {
    _value = widget.value;

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100))
          ..addListener(() => setState(() {
                _value = _valueTween.evaluate(_controller);
              }));
    super.initState();
  }

  @override
  void didUpdateWidget(ProgressAnimation oldWidget) {
    if (oldWidget.value != widget.value) {
      _valueTween = Tween(begin: oldWidget.value, end: widget.value);
      _controller.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _value);
  }
}

typedef Widget ProgressBuilder(BuildContext context, double value);
