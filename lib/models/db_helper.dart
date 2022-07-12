import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static getNames() async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'names.db'),
    );

    List<Map<String, dynamic>> tmp =
        await database.rawQuery("SELECT * FROM sqlite_master ORDER BY name");
   var tableList =
        List.generate(tmp.length - 1, (index) => tmp[index + 1]['name']);
        return tableList;

  }
}
