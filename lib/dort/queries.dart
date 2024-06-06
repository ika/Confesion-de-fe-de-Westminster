// 5 points database queries



import 'package:confesion_de_fe_de_westminster/dort/model.dart';
import 'package:confesion_de_fe_de_westminster/dort/provider.dart';
import 'package:confesion_de_fe_de_westminster/utils/const.dart';

DortProvider dortProvider = DortProvider();

const String _dbTable = Constants.dortTable;

class DortQueries {

  Future<List<Dort>> getParagraphs() async {

    final db = await dortProvider.database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM $_dbTable");

    List<Dort> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return Dort(
                id: maps[i]['id'],
                h: maps[i]['h'],
                t: maps[i]['t'],
              );
            },
          )
        : [];

    return list;
  }
}
