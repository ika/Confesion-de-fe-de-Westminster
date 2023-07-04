import 'package:confesion_de_fe_de_westminster/bmarks/bmHelper.dart';
import 'package:confesion_de_fe_de_westminster/bmarks/bmModel.dart';
import 'package:confesion_de_fe_de_westminster/constants.dart';
import 'package:sqflite/sqflite.dart';

class BMQueries {
  final String _dbTable = Constants.bMTable;
  final BMHelper bmHelper = BMHelper();

  Future<void> saveBookMark(BMModel model) async {
    final db = await bmHelper.db;
    await db.insert(
      _dbTable,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteBookMark(int id) async {
    final db = await bmHelper.db;
    await db.delete(_dbTable, where: "id = ?", whereArgs: [id]);
  }

  Future<List<BMModel>> getBookMarkList() async {
    final db = await bmHelper.db;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT id, title, subtitle, detail, page FROM $_dbTable ORDER BY id DESC");

    List<BMModel> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return BMModel(
                id: maps[i]['id'],
                title: maps[i]['title'],
                subtitle: maps[i]['subtitle'],
                detail: maps[i]['detail'],
                page: maps[i]['page'],
              );
            },
          )
        : [];
    return list;
  }
}
