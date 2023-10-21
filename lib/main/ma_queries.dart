import 'dart:async';
import 'ma_model.dart';
import 'ma_helper.dart';

DBProvider dbProvider = DBProvider();

class DbQueries {
  final String tableName = 'ptexts'; // plain text

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
