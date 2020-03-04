import 'package:flutter/material.dart';

class Task {
  static final tblTask = "Tasks";
  static final dbId = "id";
  static final dbTitle = "title";
  static final dbComment = "comment";
  static final dbDueAt = "dueAt";
  static final dbRemindAt = "remindAt";
  static final dbDone = "done";
  static final dbCategoryID = "categoryId";

  int id;
  String title;
  String comment;
  DateTime dueAt;
  DateTime remindAt;
  bool done;
  int categoryId;
  int selectedCategoryIndex = 0;
  int selectedDayIndex = 0;
  TimeOfDay pickedTime;

  Task(
      {this.id,
      this.title,
      this.comment,
      this.dueAt,
      this.remindAt,
      this.done = false,
      this.categoryId});

  Task.fromMap(Map<String, dynamic> map) {
    this.id = map[dbId];
    this.title = map[dbTitle];
    this.comment = map[dbComment];
    this.dueAt = DateTime.fromMillisecondsSinceEpoch(map[dbDueAt]);
    this.remindAt = map[dbRemindAt] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(map[dbRemindAt]);
    this.done = map[dbDone] == 0 ? false : true;
    this.categoryId = map[dbCategoryID];
  }

  Map<String, dynamic> toMap() => {
        dbId: this.id,
        dbTitle: this.title,
        dbComment: this.comment,
        dbDueAt: this.dueAt.millisecondsSinceEpoch,
        dbRemindAt:
            this.remindAt == null ? null : this.remindAt.millisecondsSinceEpoch,
        dbDone: this.done == true ? 1 : 0,
        dbCategoryID: this.categoryId
      };

  @override
  String toString() {
    return 'Task{id: $id, title: $title, comment: $comment, dueAt: $dueAt, remindAt: $remindAt, done: $done, categoryId: $categoryId, selectedCategoryIndex: $selectedCategoryIndex, selectedDayIndex: $selectedDayIndex, pickedTime: $pickedTime}';
  }
}
