import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static const String tableLogin = 'login';
  static const String columnId = 'id';
  static const String columnUsername = 'username';
  static const String columnPassword = 'password';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'login.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $tableLogin ('
      '$columnId INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$columnUsername TEXT NOT NULL,'
      '$columnPassword TEXT NOT NULL'
      ')'
    );
  }

  Future<int> insertUser(String username, String password) async {
    Database db = await database;
    return await db.insert(
      tableLogin,
      {columnUsername: username, columnPassword: password},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Função para verificar login
  Future<bool> login(String username, String password) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      tableLogin,
      where: '$columnUsername = ? AND $columnPassword = ?',
      whereArgs: [username, password],
    );
    return result.isNotEmpty; // Retorna true se o usuário foi encontrado
  }
}
