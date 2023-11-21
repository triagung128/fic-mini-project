import 'package:dartz/dartz.dart';

import 'package:fic_mini_project/common/failure.dart';
import 'package:fic_mini_project/domain/entity/transaction.dart';
import 'package:fic_mini_project/domain/repositories/transaction_repository.dart';

class SaveTransaction {
  final TransactionRepository repository;

  SaveTransaction(this.repository);

  Future<Either<Failure, void>> execute(TransactionEntity transaction) {
    return repository.saveTransaction(transaction);
  }
}
