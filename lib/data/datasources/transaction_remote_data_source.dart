import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fic_mini_project/data/models/point_model.dart';
import 'package:fic_mini_project/data/models/transaction_model.dart';
import 'package:fic_mini_project/data/models/user_model.dart';

abstract class TransactionRemoteDataSource {
  Future<List<TransactionModel>> getAllTransactions();
  Future<List<TransactionModel>> getAllTransactionsByUserId();
  Future<void> saveTransaction(TransactionModel transaction);
}

class TransactionRemoteDataSourceImpl extends TransactionRemoteDataSource {
  FirebaseAuth firebaseAuth;
  FirebaseFirestore firebaseFirestore;

  TransactionRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final transactionCollection = await firebaseFirestore
        .collection('transactions')
        .orderBy('created_at', descending: true)
        .get();

    final docs = transactionCollection.docs;
    if (docs.isEmpty) {
      return [];
    } else {
      return docs.map((doc) => TransactionModel.fromSnapshot(doc)).toList();
    }
  }

  @override
  Future<List<TransactionModel>> getAllTransactionsByUserId() async {
    final userId = firebaseAuth.currentUser!.uid;

    final transactionCollection = await firebaseFirestore
        .collection('transactions')
        .orderBy('created_at', descending: true)
        .where('user.id', isEqualTo: userId)
        .get();

    final docs = transactionCollection.docs;
    if (docs.isEmpty) {
      return [];
    } else {
      return docs.map((doc) => TransactionModel.fromSnapshot(doc)).toList();
    }
  }

  @override
  Future<void> saveTransaction(TransactionModel transaction) async {
    final userId = firebaseAuth.currentUser!.uid;

    final cashbackPoints = (transaction.cart.totalPrice * 0.1).toInt();

    final addNewPoint = PointModel(
      userId: userId,
      point: cashbackPoints,
      isEntry: true,
      createdAt: DateTime.now(),
    );

    await firebaseFirestore
        .collection('points_history')
        .add(addNewPoint.toDocument());

    if (transaction.usePoint > 0) {
      final decreasePoint = PointModel(
        userId: userId,
        point: transaction.usePoint,
        isEntry: false,
        createdAt: DateTime.now(),
      );

      await firebaseFirestore
          .collection('points_history')
          .add(decreasePoint.toDocument());
    }

    final user = await firebaseFirestore.collection('users').doc(userId).get();
    final pointNow = UserModel.fromSnapshot(user).point;

    await firebaseFirestore
        .collection('users')
        .doc(userId)
        .update({'point': (pointNow! - transaction.usePoint) + cashbackPoints});

    await firebaseFirestore
        .collection('transactions')
        .add(transaction.toDocument());
  }
}
