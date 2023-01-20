import 'package:equatable/equatable.dart';
import 'package:fic_mini_project/domain/entity/transaction.dart';
import 'package:fic_mini_project/domain/usecases/get_all_transactions.dart';
import 'package:fic_mini_project/domain/usecases/get_all_transactions_by_user_id.dart';
import 'package:fic_mini_project/domain/usecases/save_transaction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetAllTransactions getAllTransactions;
  final GetAllTransactionsByUserId getAllTransactionsByUserId;
  final SaveTransaction saveTransaction;

  TransactionBloc({
    required this.getAllTransactions,
    required this.getAllTransactionsByUserId,
    required this.saveTransaction,
  }) : super(TransactionInitial()) {
    on<OnFetchAllTransactions>((event, emit) async {
      emit(TransactionLoading());

      final result = await getAllTransactions.execute();

      result.fold(
        (failure) => emit(TransactionFailure(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(TransactionEmpty());
          } else {
            emit(AllTransactionsLoaded(data));
          }
        },
      );
    });

    on<OnFetchAllTransactionsByUserId>((event, emit) async {
      emit(TransactionLoading());

      final result = await getAllTransactionsByUserId.execute();

      result.fold(
        (failure) => emit(TransactionFailure(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(TransactionEmpty());
          } else {
            emit(AllTransactionsLoaded(data));
          }
        },
      );
    });

    on<OnSaveTransaction>((event, emit) async {
      emit(TransactionLoading());

      final result = await saveTransaction.execute(event.transaction);

      result.fold(
        (failure) => emit(TransactionFailure(failure.message)),
        (_) => emit(TransactionSuccess()),
      );
    });
  }
}
