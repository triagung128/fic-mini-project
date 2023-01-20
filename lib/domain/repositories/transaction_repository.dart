import 'package:dartz/dartz.dart';
import 'package:fic_mini_project/common/failure.dart';
import 'package:fic_mini_project/domain/entity/transaction.dart';

abstract class TransactionRepository {
  Future<Either<Failure, List<TransactionEntity>>> getAllTransactions();
  Future<Either<Failure, List<TransactionEntity>>> getAllTransactionsByUserId();
  Future<Either<Failure, void>> saveTransaction(TransactionEntity transaction);
}
