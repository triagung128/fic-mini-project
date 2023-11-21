import 'package:dartz/dartz.dart';

import 'package:fic_mini_project/common/exception.dart';
import 'package:fic_mini_project/common/failure.dart';
import 'package:fic_mini_project/data/datasources/product_local_data_source.dart';
import 'package:fic_mini_project/data/models/product_model.dart';
import 'package:fic_mini_project/domain/entity/product.dart';
import 'package:fic_mini_project/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final result = await localDataSource.getAllProducts();
      return Right(result.map((product) => product.toEntity()).toList());
    } on DatabaseException catch (_) {
      return const Left(DatabaseFailure('Gagal mendapatkan data produk'));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> insertProduct(Product product) async {
    try {
      final result = await localDataSource.insertProduct(
        ProductModel.fromEntity(product),
      );
      return Right(result);
    } on DatabaseException catch (_) {
      return const Left(DatabaseFailure('Gagal menambahkan produk'));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeProduct(Product product) async {
    try {
      final result = await localDataSource.removeProduct(
        ProductModel.fromEntity(product),
      );
      return Right(result);
    } on DatabaseException catch (_) {
      return const Left(DatabaseFailure('Gagal menghapus produk'));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> updateProduct(Product product) async {
    try {
      final result = await localDataSource.updateProduct(
        ProductModel.fromEntity(product),
      );
      return Right(result);
    } on DatabaseException catch (_) {
      return const Left(DatabaseFailure('Gagal update produk'));
    } catch (e) {
      rethrow;
    }
  }
}
