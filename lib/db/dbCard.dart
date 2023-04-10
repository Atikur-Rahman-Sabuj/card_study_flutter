import 'package:card_study_flutter/db/dbTopic.dart';
import 'package:card_study_flutter/db/dbUtils.dart';
import 'package:card_study_flutter/models/studyCard.dart';
import 'package:sqflite/sqflite.dart';

class DBCard {
  DBCard._privateConstructor();
  static final DBCard instance = DBCard._privateConstructor();

  static const String tableName = "cards";
  static const String createTable =
      "CREATE TABLE $tableName( id INTEGER PRIMARY KEY AUTOINCREMENT, topicId INTEGER, frontTitle TEXT, backTitle TEXT, frontDescription TEXT, backDescription TEXT, favorite BOOLEAN, priority INTEGER, createdAt TEXT)";

  static Future<int> insert(StudyCard card) async {
    Database db = await DBUtils.instance.db;
    card.createdAt = DateTime.now().toString();
    return await db.insert(tableName, card.toJson());
  }

  static Future<List<StudyCard>> getAll() async {
    Database db = await DBUtils.instance.db;
    return (await db.query(tableName))
        .map((e) => StudyCard.fromJson(e))
        .toList();
  }

  static Future<StudyCard?> getById(int id) async {
    Database db = await DBUtils.instance.db;
    List<Map<String, dynamic>> result =
        await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return StudyCard.fromJson(result.first);
    }
    return null;
  }

  static Future<List<StudyCard>> getByTopicId(int id) async {
    Database db = await DBUtils.instance.db;
    List<Map<String, dynamic>> result =
        await db.query(tableName, where: 'topicId = ?', whereArgs: [id]);
    return result.map((e) => StudyCard.fromJson(e)).toList();
  }

  static Future<int> update(StudyCard card) async {
    Database db = await DBUtils.instance.db;
    return await db.update(tableName, card.toJson(),
        where: 'id = ?', whereArgs: [card.id]);
  }

  static Future<int> delete(StudyCard card) async {
    Database db = await DBUtils.instance.db;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [card.id]);
  }
}
