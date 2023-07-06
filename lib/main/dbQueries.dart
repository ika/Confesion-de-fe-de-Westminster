import 'dart:async';
import 'mModel.dart';
import 'dbHelper.dart';

DBProvider dbProvider = DBProvider();

class DbQueries {
  final String tableName = 'texts';

  Future<List<Chapter>> getChapters() async {
    final db = await dbProvider.database;

    var res = await db.query(tableName);

    List<Chapter> list = res.isNotEmpty
        ? res.map((tableName) => Chapter.fromJson(tableName)).toList()
        : [];

    return list;
  }

  Future<List<Chapter>> getChapterInfo(int id) async {
    final db = await dbProvider.database;

    var res = await db
        .rawQuery('''SELECT chap,title FROM $tableName WHERE id=?''', [id]);

    List<Chapter> list = res.isNotEmpty
        ? res.map((tableName) => Chapter.fromJson(tableName)).toList()
        : [];

    return list;
  }
}
