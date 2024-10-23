import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  DbHelper._();
  static DbHelper dbHelper = DbHelper._();

  String tableName = "contact";
  Database? _db;

  Future get database async => _db ?? await initDb();

  Future<Database?> initDb() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, "contact.db");

    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        String sql = '''CREATE TABLE $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT NOT NULL,
        chat TEXT NOT NULL,
        img TEXT,
        date TEXT NOT NULL,
        time TEXT NOT NULL
        )''';
        await db.execute(sql);
      },
    );
    return _db;
  }

  Future<void> insertData(String name,String phone,String chat,String img,String date,String time) async {
    Database? db = await database;
    String sql = '''INSERT INTO $tableName(name,phone,chat,img,date,time) VALUES(?,?,?,?,?,?)''';
    List args = [name,phone,chat,img,date,time];
    await db!.rawInsert(sql,args);
  }

  Future<List<Map<String, Object?>>> getAllData() async {
    Database? db = await database;
    String sql = '''SELECT * FROM $tableName''';
    return db!.rawQuery(sql);
  }

  Future<void> deleteData(int id) async {
    Database? db = await database;
    String sql = '''DELETE FROM $tableName WHERE id = ?''';
    List args = [id];
    await db!.rawDelete(sql,args);
  }

  Future<void> updateData(String name,String phone,String chat,String img,int id) async {
    Database? db = await database;
    String sql = '''UPDATE $tableName SET name = ?, phone = ?, chat = ?, img = ? WHERE id = ?''';
    List args = [name, phone, chat, img, id];
    await db!.rawUpdate(sql, args);
  }
}