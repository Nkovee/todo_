import 'dart:io';
import 'package:flutter_application_2/model/model.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  DataBaseHelper._privateConstructior();
  static final DataBaseHelper instance = DataBaseHelper._privateConstructior();
  static Database? _database;
  Future<Database> get dataBase async => _database ??= await _initdatabase();
  Future<Database> _initdatabase() async {
    Directory documentDirectory = await getApplicationSupportDirectory();
    String path = join(documentDirectory.path, 'todos');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("""
     CREATE TABLE todos(
      name TEXT,
      address TEXT,
      id INTEGGER PRIMARY KEY AUTOINCREMENT
      )

      """);
  }

  Future<int> addUsers(Model model) async {
    try {
      Database db = await instance.dataBase;
      return await db.insert("todos", model.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Model>> gettodos() async {
    try {
      Database db = await instance.dataBase;
      var todos = await db.query("todos", orderBy: "id");
      // ignore: no_leading_underscores_for_local_identifiers
      List<Model> _todos = todos.isNotEmpty
          ? todos.map((model) => Model.fromJson(model)).toList()
          : [];
      return _todos;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> deleteUser(int? id) async {
    try {
      Database db = await instance.dataBase;
      return await db.delete("todos", where: 'id=?', whereArgs: [id]);
    } catch (e) {
      rethrow;
    }
  }

  Future upDateUser(Model model) async {
    try {
      Database db = await instance.dataBase;
      return await db.update("todos", model.toJson(),
          where: 'id==?', whereArgs: [model.id]);
    } catch (e) {
      rethrow;
    }
  }
}
