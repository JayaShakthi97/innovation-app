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

  Task(
      {this.id,
      this.title,
      this.comment,
      this.dueAt,
      this.remindAt,
      this.done,
      this.categoryId});

  Task.fromMap(Map<String, dynamic> map) {
    this.id = map[dbId];
    this.title = map[dbTitle];
    this.comment = map[dbComment];
    this.dueAt = DateTime.fromMillisecondsSinceEpoch(map[dbDueAt]);
    this.remindAt = DateTime.fromMillisecondsSinceEpoch(map[dbRemindAt]);
    this.done = map[dbDone] == 0 ? false : true;
    this.categoryId = map[dbCategoryID];
  }
}
