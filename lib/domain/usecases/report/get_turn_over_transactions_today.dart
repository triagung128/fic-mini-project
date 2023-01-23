import 'package:fic_mini_project/domain/repositories/report_repository.dart';

class GetTurnOverTransactionsToday {
  final ReportRepository repository;

  GetTurnOverTransactionsToday(this.repository);

  Future<int> execute() {
    return repository.getTurnOverTransactionsToday();
  }
}
