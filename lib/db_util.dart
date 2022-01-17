import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'models/pass.dart';

class DbUtil {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'safepassword.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE pass (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, pass TEXT, description TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbUtil.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Pass>> getData(String table) async {
    final db = await DbUtil.database();
    final dataList = await db.query(table);

    List<Pass> _items = dataList
        .map(
          (item) => Pass(
            id: int.parse(item['id'].toString()),
            title: item['title'].toString(),
            pass: item['pass'].toString(),
            description: item['description'].toString(),
          ),
        )
        .toList();

    return _items;
  }

  static Future<Pass> getPassById(int id) async {
    final db = await DbUtil.database();
    final dataList = await db.query(
      'pass',
      columns: ['id', 'title', 'pass', 'description'],
      where: "id = ?",
      whereArgs: [id],
    );

    List<Pass> _items = dataList.map((item) {
      return Pass(
        id: int.parse(item['id'].toString()),
        title: item['title'].toString(),
        pass: item['pass'].toString(),
        description: item['description'].toString(),
      );
    }).toList();

    return _items[0];
  }

  static Future<List<Pass>> getPassByTitle(String title) async {
    final db = await DbUtil.database();
    final dataList = await db.query(
      'pass',
      columns: ['id', 'title', 'pass', 'description'],
      where: "title LIKE ?",
      whereArgs: ['%$title%'],
    );

    return dataList.map((item) {
      return Pass(
        id: int.parse(item['id'].toString()),
        title: item['title'].toString(),
        pass: item['pass'].toString(),
        description: item['description'].toString(),
      );
    }).toList();
  }

  static Future<void> delete(int id) async {
    final db = await DbUtil.database();
    db.delete('pass', where: 'id = ?', whereArgs: [id]);
  }
}
