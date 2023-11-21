import 'package:dartz/dartz.dart';

import 'package:fic_mini_project/common/failure.dart';
import 'package:fic_mini_project/data/datasources/transaction_remote_data_source.dart';
import 'package:fic_mini_project/data/models/transaction_model.dart';
import 'package:fic_mini_project/domain/entity/transaction.dart';
import 'package:fic_mini_project/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;

  TransactionRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<TransactionEntity>>> getAllTransactions() async {
    try {
      final result = await remoteDataSource.getAllTransactions();
      return Right(result.map((item) => item.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TransactionEntity>>>
      getAllTransactionsByUserId() async {
    try {
      final result = await remoteDataSource.getAllTransactionsByUserId();
      return Right(result.map((item) => item.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveTransaction(
    TransactionEntity transaction,
  ) async {
    try {
      final result = await remoteDataSource.saveTransaction(
        TransactionModel.fromEntity(transaction),
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
