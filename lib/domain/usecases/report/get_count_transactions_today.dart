import 'package:fic_mini_project/domain/repositories/report_repository.dart';

class GetCountTransactionsToday {
  final ReportRepository repository;

  GetCountTransactionsToday(this.repository);

  Future<int> execute() {
    return repository.getCountTransactionsToday();
  }
}
