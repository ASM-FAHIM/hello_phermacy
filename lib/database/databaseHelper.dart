
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:sqflite/sqflite.dart' as sql;


class DatabaseHelper{

  //create table
  static Future<void> createTable(sql.Database database) async {
    await database.execute(''' 
    CREATE TABLE workNote(
    empID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
    columnTask TEXT NOT NULL
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    ''');
  }

  //init database
  static Future<sql.Database> db() async{
    return sql.openDatabase(
      'workNote.db',
      version: 1,
      onCreate: (sql.Database db, int version) async{
        await createTable(db) ;
      }
    );
  }

  //create user
  static Future<int> createUser (String tasks) async{
    final db = await DatabaseHelper.db();
    final data = {"workNote" : tasks};
    final id = await db.insert("workNote", data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
}

//all user list
static Future  getUserList() async{

    final db = await DatabaseHelper.db();

    return db.query("workNote", orderBy: "id");
}

//update database
static Future<int> updateUserList(String tasks, int id) async{

    final db = await DatabaseHelper.db();
    final data = {"workNote": tasks, "createdAt": DateTime.now().toString()};
    final result = await db.update("workNote", data, where: "id =?", whereArgs: [id]);
    return id;

}

// //delete UserList
// static Future<void> deleteUserList(int id) async {
//   final db = DatabaseHelper.db();
//
//
// }

}