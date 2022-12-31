import 'package:fic_mini_project/data/models/category_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/fic_mini_project.db';

    final db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  static const String _tblCategory = 'tb_category';

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tblCategory (
        id INTEGER PRIMARY KEY,
        name TEXT
      );
    ''');
  }

  Future<List<Map<String, dynamic>>> getAllCategory() async {
    final db = await database;
    return await db!.query(
      _tblCategory,
      orderBy: 'id DESC',
    );
  }

  Future<int> insertCategory(CategoryModel category) async {
    final db = await database;
    return await db!.insert(_tblCategory, category.toJson());
  }

  Future<int> updateCategory(CategoryModel category) async {
    final db = await database;
    return await db!.update(
      _tblCategory,
      category.toJson(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  Future<int> removeCategory(int id) async {
    final db = await database;
    return await db!.delete(
      _tblCategory,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
