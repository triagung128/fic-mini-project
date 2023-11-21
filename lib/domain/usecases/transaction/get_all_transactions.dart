import 'package:dartz/dartz.dart';

import 'package:fic_mini_project/common/failure.dart';
import 'package:fic_mini_project/domain/entity/transaction.dart';
import 'package:fic_mini_project/domain/repositories/transaction_repository.dart';

class GetAllTransactions {
  final TransactionRepository repository;

  GetAllTransactions(this.repository);

  Future<Either<Failure, List<TransactionEntity>>> execute() {
    return repository.getAllTransactions();
  }
}
