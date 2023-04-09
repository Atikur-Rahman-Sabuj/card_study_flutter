import 'package:card_study_flutter/db/dbCard.dart';
import 'package:card_study_flutter/db/dbTopic.dart';
import 'package:sqflite/sqflite.dart';

class DBUtils {
  static Database? _db;
  static const String _databaseName = 'card-learn.db';
  static const int _version = 1;

  DBUtils._privateConstructor();
  static final DBUtils instance = DBUtils._privateConstructor();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDatabase();
    return _db!;
  }

  _initDatabase() async {
    String _path = await getDatabasesPath() + _databaseName;
    return await openDatabase(
      _path,
      version: _version,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(DBTopic.createTable);
    await db.execute(DBCard.createTable);
  }
}
