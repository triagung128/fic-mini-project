import 'package:equatable/equatable.dart';
import 'package:fic_mini_project/domain/usecases/report/get_count_transactions_today.dart';
import 'package:fic_mini_project/domain/usecases/report/get_turn_over_transactions_today.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final GetCountTransactionsToday getCountTransactionsToday;
  final GetTurnOverTransactionsToday getTurnOverTransactionsToday;

  ReportBloc({
    required this.getCountTransactionsToday,
    required this.getTurnOverTransactionsToday,
  }) : super(ReportInitial()) {
    on<OnGetReportTransactionsToday>((event, emit) async {
      emit(ReportLoading());

      final countTransactions = await getCountTransactionsToday.execute();
      final turnOverTransactions = await getTurnOverTransactionsToday.execute();

      emit(
        ReportLoaded(
          countTransactions: countTransactions,
          turnOverTransactions: turnOverTransactions,
        ),
      );
    });
  }
}
