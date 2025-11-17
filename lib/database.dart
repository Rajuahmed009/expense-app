import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'expense_app.db');
    return await openDatabase(path, version: 1, onCreate: (db, v) async {
      await db.execute('''
        CREATE TABLE data (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          amount INTEGER,
          note TEXT,
          type TEXT,
          date TEXT
        )
      ''');
    });
  }

  Future<void> insertData(int amount, String note, String type) async {
    final db = await database;
    await db.insert('data', {
      'amount': amount,
      'note': note,
      'type': type,
      'date': DateTime.now().toString(),
    });
  }

  Future<int> getTotalByType(String type) async {
    final db = await database;
    final res = await db.rawQuery("SELECT SUM(amount) AS total FROM data WHERE type = ?", [type]);
    final val = res.first['total'];
    if (val == null) return 0;
    if (val is int) return val;
    return int.parse(val.toString());
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    final db = await database;
    return await db.query('data', orderBy: 'id DESC');
  }
}
