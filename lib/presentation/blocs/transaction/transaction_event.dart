part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class OnFetchAllTransactions extends TransactionEvent {}

class OnFetchAllTransactionsByUserId extends TransactionEvent {}

class OnSaveTransaction extends TransactionEvent {
  final TransactionEntity transaction;

  const OnSaveTransaction(this.transaction);

  @override
  List<Object> get props => [transaction];
}
