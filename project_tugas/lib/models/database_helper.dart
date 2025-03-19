import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'user.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('kasir_app.db');
    return _database!;
  }

  // Membuka dan membuat database SQLite
  Future<Database> _initDB(String path) async {
    final dbPath = await getDatabasesPath();
    final pathDB = join(dbPath, path);

    return await openDatabase(
      pathDB,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            fullName TEXT,
            username TEXT UNIQUE,
            birthDate TEXT,
            gender TEXT,
            password TEXT,
            address TEXT
          )
        ''');
      },
    );
  }

  // Menambahkan pengguna baru
  Future<int> insertUser(User user) async {
    final db = await instance.database;
    return await db.insert('users', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Mengambil pengguna berdasarkan username dan password untuk login
  Future<User?> getUserByUsernamePassword(
      String username, String password) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }
}
