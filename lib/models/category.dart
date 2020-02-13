import 'package:flutter/material.dart';

class Category {
  static final tblCategory = "categories";
  static final dbId = "id";
  static final dbTitle = "title";
  static final dbIcon = "icon";
  static final dbColorCode = "colorCode";

  static final List<IconData> iconList = [
    Icons.person,
    Icons.work,
    Icons.school,
    Icons.comment,
  ];

  int _id;
  String _title;
  IconData _icon;
  Color _color;

  Category(this._title, this._icon, this._color);

  Category.fromMap(Map<String, dynamic> map) {
    this._id = map[dbId];
    this._title = map[dbTitle];
    this._icon = iconList[map[dbIcon]];
    this._color = Color(map[dbColorCode]);
  }

  Map<String, dynamic> toMap() => {
        dbId: this._id,
        dbTitle: this._title,
        dbColorCode: this._color.value,
        dbIcon: iconList.indexOf(this._icon),
      };

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Color get color => _color;

  set color(Color value) {
    _color = value;
  }

  IconData get icon => _icon;

  set icon(IconData value) {
    _icon = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }
}
