import 'dart:async';

import 'package:confesion_de_fe_de_westminster/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Bookmarks database helper

class BMHelper {
  final String _dbName = Constants.bMDatabase;
  final String _dbTable = Constants.bMTable;

  static final BMHelper _instance = BMHelper.internal();

  factory BMHelper() {
    return _instance;
  }

  static dynamic _database;

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  BMHelper.internal();

  Future close() async {
    return _database.close();
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _dbName);

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) async {},
      onCreate: (Database db, int version) async {
        // Create the note table
        await db.execute('''
                CREATE TABLE IF NOT EXISTS $_dbTable (
                    id INTEGER PRIMARY KEY,
                    title TEXT DEFAULT '',
                    subtitle TEXT DEFAULT '',
                    detail TEXT DEFAULT '',
                    page TEXT DEFAULT ''
                )
            ''');
      },
    );
  }
}
