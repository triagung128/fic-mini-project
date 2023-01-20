import 'package:fic_mini_project/data/datasources/report_remote_data_source.dart';
import 'package:fic_mini_project/domain/repositories/report_repository.dart';

class ReportRepositoryImpl extends ReportRepository {
  final ReportRemoteDataSource remoteDataSource;

  ReportRepositoryImpl(this.remoteDataSource);

  @override
  Future<int> getCountTransactionsToday() async {
    try {
      return await remoteDataSource.getCountTransactionsToday();
    } catch (_) {
      return 0;
    }
  }

  @override
  Future<int> getTurnOverTransactionsToday() async {
    try {
      return await remoteDataSource.getTurnOverTransactionsToday();
    } catch (_) {
      return 0;
    }
  }
}
