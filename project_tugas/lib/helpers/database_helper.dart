import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/food.dart';
import '../models/drink.dart';
import 'package:project_tugas/models/user.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('kasir_app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS food (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      price REAL NOT NULL
    )
  ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS drink (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      price REAL NOT NULL
    )
  ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      fullName TEXT,
      username TEXT UNIQUE,
      birthDate TEXT,
      gender TEXT,
      password TEXT,
      address TEXT
    )
  ''');
  }

  // Menambahkan pengguna baru
  Future<int> insertUser(User user) async {
    final db = await instance.database;
    return await db.insert('users', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // User Login
  Future<Map<String, dynamic>?> loginUser(
      String username, String password) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  // Food methods
  Future<int> insertFood(Food food) async {
    final db = await database;
    return await db.insert('food', food.toMap());
  }

  Future<List<Food>> getFoods() async {
    final db = await database;
    final result = await db.query('food');
    return result.map((map) => Food.fromMap(map)).toList();
  }

  Future<int> updateFood(Food food) async {
    final db = await database;
    return await db.update(
      'food',
      food.toMap(),
      where: 'id = ?',
      whereArgs: [food.id],
    );
  }

  Future<int> deleteFood(int id) async {
    final db = await database;
    return await db.delete(
      'food',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Drink methods
  Future<int> insertDrink(Drink drink) async {
    final db = await database;
    return await db.insert('drink', drink.toMap());
  }

  Future<List<Drink>> getDrinks() async {
    final db = await database;
    final result = await db.query('drink');
    return result.map((map) => Drink.fromMap(map)).toList();
  }

  Future<int> updateDrink(Drink drink) async {
    final db = await database;
    return await db.update(
      'drink',
      drink.toMap(),
      where: 'id = ?',
      whereArgs: [drink.id],
    );
  }

  Future<int> deleteDrink(int id) async {
    final db = await database;
    return await db.delete(
      'drink',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Get count for dashboard
  Future<int> getCount(String table) async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM $table');
    return Sqflite.firstIntValue(result) ?? 0;
  }
}
