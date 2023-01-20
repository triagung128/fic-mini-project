abstract class ReportRepository {
  Future<int> getCountTransactionsToday();
  Future<int> getTurnOverTransactionsToday();
}
