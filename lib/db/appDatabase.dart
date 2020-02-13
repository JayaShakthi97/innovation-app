import 'dart:io';

import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/models/category.dart';
import 'package:innovation_flutter_app/models/task.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase _appDatabase = AppDatabase._internal();

  //private internal constructor to make it singleton
  AppDatabase._internal();

  Database _database;

  static AppDatabase get() {
    return _appDatabase;
  }

  bool didInit = false;

  /// Use this method to access the database which will provide you future of [Database],
  /// because initialization of the database (it has to go through the method channel)
  Future<Database> getDb() async {
    if (!didInit) await _init();
    return _database;
  }

  Future _init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "todo.db");
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await _createCategoryTable(db);
      await _createTaskTable(db);
      //await _insertCategories(db);
    });
  }

  Future _createCategoryTable(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute("CREATE TABLE ${Category.tblCategory} ("
          "${Category.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${Category.dbTitle} TEXT,"
          "${Category.dbIcon} INTEGER,"
          "${Category.dbColorCode} INTEGER);");
    });
  }

  Future _createTaskTable(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute("CREATE TABLE ${Task.tblTask} ("
          "${Task.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${Task.dbTitle} TEXT,"
          "${Task.dbComment} TEXT,"
          "${Task.dbDueAt} LONG,"
          "${Task.dbRemindAt} LONG,"
          "${Task.dbDone} INTEGER,"
          "${Task.dbCategoryID} INTEGER,"
          "FOREIGN KEY (${Task.dbCategoryID}) "
          "REFERENCES ${Category.tblCategory}(${Category.dbId}) ON DELETE CASCADE);");
    });
  }

  Future _insertCategories(Database db) {
    return db.transaction((Transaction txn) async {
      await txn.rawInsert("INSERT INTO ${Category.tblCategory}("
          "${Category.dbTitle}, ${Category.dbIcon}, ${Category.dbColorCode}) "
          "VALUES(\"Personal\", 0, ${Colors.blue.value})");

      await txn.rawInsert("INSERT INTO ${Category.tblCategory}("
          "${Category.dbTitle}, ${Category.dbIcon}, ${Category.dbColorCode}) "
          "VALUES(\"Work\", 1, ${Colors.orange.value})");

      await txn.rawInsert("INSERT INTO ${Category.tblCategory}("
          "${Category.dbTitle}, ${Category.dbIcon}, ${Category.dbColorCode}) "
          "VALUES(\"Academic\", 2, ${Colors.green.value})");
    });
  }
}
