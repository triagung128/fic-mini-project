import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

abstract class ReportRemoteDataSource {
  Future<int> getCountTransactionsToday();
  Future<int> getTurnOverTransactionsToday();
}

class ReportRemoteDataSourceImpl extends ReportRemoteDataSource {
  FirebaseFirestore firebaseFirestore;

  ReportRemoteDataSourceImpl(this.firebaseFirestore);

  @override
  Future<int> getCountTransactionsToday() async {
    final transactionCollection =
        await firebaseFirestore.collection('transactions').get();

    return transactionCollection.docs
        .where(
          (element) => element
              .data()['created_at']
              .toString()
              .contains(DateFormat('yyyy-MM-dd').format(DateTime.now())),
        )
        .length;
  }

  @override
  Future<int> getTurnOverTransactionsToday() async {
    int sum = 0;

    final transactionCollection =
        await firebaseFirestore.collection('transactions').get();

    final docs = transactionCollection.docs.where(
      (element) => element
          .data()['created_at']
          .toString()
          .contains(DateFormat('yyyy-MM-dd').format(DateTime.now())),
    );

    for (var element in docs) {
      final int totalPrice = element.data()['end_total_price'];
      sum += totalPrice;
    }

    return sum;
  }
}
