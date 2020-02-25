import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/utils/app_constant.dart';

class Category {
  static final tblCategory = "categories";
  static final dbId = "id";
  static final dbTitle = "title";
  static final dbIcon = "icon";
  static final dbColorCode = "colorCode";

  int _id;
  String _title;
  IconData _icon;
  Color _color;
  bool _expanded;

  Category(this._title, this._icon, this._color);

  Category.update(this._id, this._title, this._icon, this._color);

  Category.fromMap(Map<String, dynamic> map) {
    this._id = map[dbId];
    this._title = map[dbTitle];
    this._icon = AppConstant.ICON_DATA[map[dbIcon]];
    this._color = Color(map[dbColorCode]);
    this._expanded = false;
  }

  Map<String, dynamic> toMap() => {
        dbId: this._id,
        dbTitle: this._title,
        dbColorCode: this._color.value,
        dbIcon: AppConstant.ICON_DATA.indexOf(this._icon),
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

  bool get isExpanded => _expanded;

  set expanded(bool value) {
    _expanded = value;
  }
}
