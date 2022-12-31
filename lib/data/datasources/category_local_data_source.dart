import 'package:fic_mini_project/common/exception.dart';
import 'package:fic_mini_project/data/db/database_helper.dart';
import 'package:fic_mini_project/data/models/category_model.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryModel>> getAllCategory();
  Future<String> insertCategory(CategoryModel category);
  Future<String> updateCategory(CategoryModel category);
  Future<String> removeCategory(int id);
}

class CategoryLocalDataSourceImpl extends CategoryLocalDataSource {
  final DatabaseHelper databaseHelper;

  CategoryLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<List<CategoryModel>> getAllCategory() async {
    try {
      final result = await databaseHelper.getAllCategory();
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
  Future<String> removeCategory(int id) async {
    try {
      await databaseHelper.removeCategory(id);
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
