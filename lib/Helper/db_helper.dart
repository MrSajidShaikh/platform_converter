
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static DatabaseHelper databaseHelper = DatabaseHelper._();

  static const String dbName = 'users.db';
  static const String tableName = 'users';

  Database? _database;

  Future<Database?> get database async => _database ?? await initDatabase();

  Future<Database?> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, dbName);
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        String sql = '''
        CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT NOT NULL,
        chatConversation TEXT NOT NULL,
        profile TEXT NOT NULL,
        date TEXT NOT NULL,
        time TEXT NOT NULL
        )
        ''';
        db.execute(sql);
      },
    );
  }

  Future<int> addUserToDatabase({
    required String name,
    required String phone,
    required String chatConversation,
    required String profile,
    required String date,
    required String time,
  }) async {
    final db = await database;
    String sql = '''
    INSERT INTO $tableName (name, phone, chatConversation, profile, date, time)
    VALUES (?, ?, ?, ?, ?, ?)
    ''';
    List args = [name, phone, chatConversation, profile, date, time];
    return await db!.rawInsert(sql, args);
  }

  Future<List<Map<String, Object?>>> readDataFromDatabase() async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName
    ''';
    return await db!.rawQuery(sql);
  }

  Future<int> updateNameInDatabase(String name, String phone,
      String chatConversation, String profile, int id) async {
    final db = await database;
    String sql = '''
    UPDATE $tableName SET name = ?, phone = ?, chatConversation = ?, profile = ? WHERE id = ?
    ''';
    List args = [name, phone, chatConversation, profile, id];
    return await db!.rawUpdate(sql, args);
  }

  Future<int> deleteUserFromDatabase(int id) async {
    final db = await database;
    String sql = '''
    DELETE FROM $tableName WHERE id = ?
    ''';
    List args = [id];
    return await db!.rawDelete(sql, args);
  }
}
