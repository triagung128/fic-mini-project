import 'package:dartz/dartz.dart';

import 'package:fic_mini_project/common/exception.dart';
import 'package:fic_mini_project/common/failure.dart';
import 'package:fic_mini_project/data/datasources/category_local_data_source.dart';
import 'package:fic_mini_project/data/models/category_model.dart';
import 'package:fic_mini_project/domain/entity/category.dart';
import 'package:fic_mini_project/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryLocalDataSource localDataSource;

  CategoryRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<Category>>> getAllCategories() async {
    try {
      final result = await localDataSource.getAllCategories();
      return Right(result.map((category) => category.toEntity()).toList());
    } on DatabaseException catch (_) {
      return const Left(DatabaseFailure('Gagal mendapatkan data kategori'));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> insertCategory(Category category) async {
    try {
      final result = await localDataSource
          .insertCategory(CategoryModel.fromEntity(category));
      return Right(result);
    } on DatabaseException catch (_) {
      return const Left(DatabaseFailure('Gagal tambah kategori'));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeCategory(Category category) async {
    try {
      final result = await localDataSource
          .removeCategory(CategoryModel.fromEntity(category));
      return Right(result);
    } on DatabaseException catch (_) {
      return const Left(DatabaseFailure('Gagal hapus kategori'));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> updateCategory(Category category) async {
    try {
      final result = await localDataSource
          .updateCategory(CategoryModel.fromEntity(category));
      return Right(result);
    } on DatabaseException catch (_) {
      return const Left(DatabaseFailure('Gagal update kategori'));
    } catch (e) {
      rethrow;
    }
  }
}
