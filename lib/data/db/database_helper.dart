import 'package:fic_mini_project/data/models/category_model.dart';
import 'package:fic_mini_project/data/models/product_model.dart';
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
  static const String _tblProduct = 'tb_product';

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tblCategory (
        id INTEGER PRIMARY KEY,
        name TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE $_tblProduct (
        id INTEGER PRIMARY KEY,
        name TEXT,
        price INTEGER,
        category_id INTEGER,
        FOREIGN KEY (category_id) REFERENCES $_tblCategory (id)
      );
    ''');
  }

  Future<List<Map<String, dynamic>>> getAllCategories() async {
    final db = await database;
    return await db!.query(
      _tblCategory,
      orderBy: 'id DESC',
    );
  }

  Future<int> insertCategory(CategoryModel category) async {
    final db = await database;
    return await db!.insert(_tblCategory, category.toMap());
  }

  Future<int> updateCategory(CategoryModel category) async {
    final db = await database;
    return await db!.update(
      _tblCategory,
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  Future<int> removeCategory(CategoryModel category) async {
    final db = await database;
    return await db!.delete(
      _tblCategory,
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  Future<List<Map<String, dynamic>>> getAllProducts() async {
    final db = await database;
    return await db!.rawQuery(
      '''
        SELECT $_tblProduct.*, $_tblCategory.name AS category_name
        FROM $_tblProduct
        INNER JOIN $_tblCategory
        ON $_tblProduct.category_id = $_tblCategory.id
      ''',
    );
  }

  Future<int> insertProduct(ProductModel product) async {
    final db = await database;
    return await db!.insert(_tblProduct, product.toMap());
  }

  Future<int> updateProduct(ProductModel product) async {
    final db = await database;
    return await db!.update(
      _tblProduct,
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> removeProduct(ProductModel product) async {
    final db = await database;
    return await db!.delete(
      _tblProduct,
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }
}
