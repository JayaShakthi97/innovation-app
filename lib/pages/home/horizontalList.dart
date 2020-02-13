import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/pages/home/horizontalListCard.dart';
import 'package:innovation_flutter_app/utils/date_util.dart';

class HorizontalList extends StatefulWidget {
  final String day;
  final DateTime date;

  const HorizontalList({Key key, this.day, this.date}) : super(key: key);

  @override
  _HorizontalListState createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: <Widget>[
          Text(widget.day +
              (widget.date == null
                  ? ' '
                  : ' | ' +
                      DateUtil.getFormattedDate(
                          widget.date.millisecondsSinceEpoch))),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) =>
                  HorizontalListCard(
                icon: Icon(Icons.person),
                title: 'Personal',
                index: index,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
