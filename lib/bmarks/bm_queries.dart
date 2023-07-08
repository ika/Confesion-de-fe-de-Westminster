import 'package:confesion_de_fe_de_westminster/bmarks/bm_helper.dart';
import 'package:confesion_de_fe_de_westminster/bmarks/bm_model.dart';
import 'package:confesion_de_fe_de_westminster/utils/constants.dart';
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
        "SELECT id, title, subtitle, pagenum FROM $_dbTable ORDER BY id DESC");

    List<BMModel> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return BMModel(
                id: maps[i]['id'],
                title: maps[i]['title'],
                subtitle: maps[i]['subtitle'],
                pagenum: maps[i]['pagenum'],
              );
            },
          )
        : [];
    return list;
  }

  Future<int> getBookMarkExists(int num) async {
    final db = await bmHelper.db;

    var cnt = Sqflite.firstIntValue(
      await db
          .rawQuery('''SELECT MAX(id) FROM $_dbTable WHERE pagenum=?''', [num]),
    );
    return cnt ?? 0;
  }
}
