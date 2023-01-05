import 'package:fic_mini_project/common/exception.dart';
import 'package:fic_mini_project/data/db/database_helper.dart';
import 'package:fic_mini_project/data/models/category_model.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryModel>> getAllCategories();
  Future<String> insertCategory(CategoryModel category);
  Future<String> updateCategory(CategoryModel category);
  Future<String> removeCategory(CategoryModel category);
}

class CategoryLocalDataSourceImpl extends CategoryLocalDataSource {
  final DatabaseHelper databaseHelper;

  CategoryLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final result = await databaseHelper.getAllCategories();
      return result.map((category) => CategoryModel.fromMap(category)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> insertCategory(CategoryModel category) async {
    try {
      await databaseHelper.insertCategory(category);
      return 'Berhasil menambahkan kategori';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeCategory(CategoryModel category) async {
    try {
      await databaseHelper.removeCategory(category);
      return 'Berhasil menghapus kategori';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> updateCategory(CategoryModel category) async {
    try {
      await databaseHelper.updateCategory(category);
      return 'Berhasil update kategori';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
