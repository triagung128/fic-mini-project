import 'package:fic_mini_project/common/exception.dart';
import 'package:fic_mini_project/data/db/database_helper.dart';
import 'package:fic_mini_project/data/models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<String> insertProduct(ProductModel product);
  Future<String> updateProduct(ProductModel product);
  Future<String> removeProduct(ProductModel product);
}

class ProductLocalDataSourceImpl extends ProductLocalDataSource {
  final DatabaseHelper databaseHelper;

  ProductLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final result = await databaseHelper.getAllProducts();
      return result.map((product) => ProductModel.fromMap(product)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> insertProduct(ProductModel product) async {
    try {
      await databaseHelper.insertProduct(product);
      return 'Berhasil menambahkan produk';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeProduct(ProductModel product) async {
    try {
      await databaseHelper.removeProduct(product);
      return 'Berhasil menghapus produk';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> updateProduct(ProductModel product) async {
    try {
      await databaseHelper.updateProduct(product);
      return 'Berhasil update produk';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
