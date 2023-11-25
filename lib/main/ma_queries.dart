import 'dart:async';
import 'package:confesion_de_fe_de_westminster/main/ma_helper.dart';
import 'package:confesion_de_fe_de_westminster/main/ma_model.dart';
import 'package:confesion_de_fe_de_westminster/utils/globals.dart';

DBProvider dbProvider = DBProvider();

String tableName = '';

class DbQueries {
  DbQueries() {
    tableName = Globals.initialText;
  }

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
