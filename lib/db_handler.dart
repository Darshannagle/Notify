import 'dart:io' as io;
import 'package:notify/model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBhelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return null;
  }

 initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'todo.db');
    var db = await openDatabase(path, version: 1, onCreate: createDatabase);
    return db;
  }

  createDatabase(Database db, int version) async {
    await db.execute(
      """
CREATE TABLE mytodo(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,desc TEXT NOT NULL,dateTime TEXT NOT NULL)""",);
  }

  Future<Model> insert(Model model) async {
    var dbClient = await db;
    await dbClient?.insert('mytodo', model.toMap());
    return model;
  }


  Future<List<Model>> getDatalist() async {
    await db;
    final List<Map<String, Object?>> QueryResult = await _db!.rawQuery(
        'SELECT * FROM mytodo');
    return QueryResult.map((e) => Model.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('mytodo', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Model model) async {
    var dbClient = await db;
    return await dbClient!.update(
        'mytodo', model.toMap(), where: 'id  = ?', whereArgs: [model.id]);
  }
}