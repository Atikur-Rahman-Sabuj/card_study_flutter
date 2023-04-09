import 'package:card_study_flutter/db/dbUtils.dart';
import 'package:card_study_flutter/models/topic.dart';
import 'package:sqflite/sqflite.dart';

class DBTopic {
  DBTopic._privateConstructor();
  static final DBTopic instance = DBTopic._privateConstructor();

  static const String tableName = "topics";
  static const String createTable =
      "CREATE TABLE $tableName( id INTEGER PRIMARY KEY AUTOINCREMENT, parentId INTEGER, title TEXT, description TEXT, favorite BOOLEAN, priority INTEGER, createdAt TEXT)";
  static Future<int> insert(Topic topic) async {
    Database db = await DBUtils.instance.db;
    return await db.insert(tableName, topic.toJson());
  }

  static Future<List<Topic>> getAll() async {
    Database db = await DBUtils.instance.db;
    return (await db.query(tableName)).map((e) => Topic.fromJson(e)).toList();
  }

  static Future<List<Topic>> getAllMainTopics() async {
    Database db = await DBUtils.instance.db;
    return (await db.query(tableName, where: 'parentId IS NULL'))
        .map((e) => Topic.fromJson(e))
        .toList();
  }

  static Future<Topic?> getById(int id) async {
    Database db = await DBUtils.instance.db;
    List<Map<String, dynamic>> result =
        await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return Topic.fromJson(result.first);
    }
    return null;
  }

  static Future<List<Topic>> getByParentId(int id) async {
    Database db = await DBUtils.instance.db;
    List<Map<String, dynamic>> result =
        await db.query(tableName, where: 'parentId = ?', whereArgs: [id]);
    return result.map((e) => Topic.fromJson(e)).toList();
  }

  static Future<int> update(Topic topic) async {
    Database db = await DBUtils.instance.db;
    return await db.update(tableName, topic.toJson(),
        where: 'id = ?', whereArgs: [topic.id]);
  }

  static Future<int> delete(Topic topic) async {
    Database db = await DBUtils.instance.db;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [topic.id]);
  }
}
