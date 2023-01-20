part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionEmpty extends TransactionState {}

class TransactionFailure extends TransactionState {
  final String message;

  const TransactionFailure(this.message);

  @override
  List<Object> get props => [message];
}

class TransactionSuccess extends TransactionState {}

class AllTransactionsLoaded extends TransactionState {
  final List<TransactionEntity> transactions;

  const AllTransactionsLoaded(this.transactions);

  @override
  List<Object> get props => [transactions];
}
