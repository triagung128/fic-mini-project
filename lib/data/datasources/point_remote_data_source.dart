import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fic_mini_project/data/models/point_model.dart';
import 'package:fic_mini_project/data/models/user_model.dart';

abstract class PointRemoteDataSource {
  Future<List<PointModel>> getAllPointsHistory();
  Future<void> savePoint(int point);
  Future<void> usePoint(int point);
}

class PointRemoteDataSourceImpl extends PointRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  PointRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  @override
  Future<List<PointModel>> getAllPointsHistory() async {
    final userId = firebaseAuth.currentUser!.uid;

    final pointCollection = await firebaseFirestore
        .collection('points_history')
        .where('user_id', isEqualTo: userId)
        .orderBy('created_at', descending: true)
        .get();

    final docs = pointCollection.docs;
    if (docs.isEmpty) {
      return [];
    } else {
      return docs.map((e) => PointModel.fromSnapshot(e)).toList();
    }
  }

  @override
  Future<void> savePoint(int point) async {
    final userId = firebaseAuth.currentUser!.uid;

    final newPoint = PointModel(
      userId: userId,
      point: point,
      isEntry: true,
      createdAt: DateTime.now(),
    );

    await firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('point')
        .add(newPoint.toDocument());

    final user = await firebaseFirestore.collection('users').doc(userId).get();
    final pointNow = UserModel.fromSnapshot(user).point;
    await firebaseFirestore.collection('users').doc(userId).update(
      {
        'point': pointNow! + point,
      },
    );
  }

  @override
  Future<void> usePoint(int point) async {
    final userId = firebaseAuth.currentUser!.uid;

    final newPoint = PointModel(
      userId: userId,
      point: point,
      isEntry: false,
      createdAt: DateTime.now(),
    );

    await firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('point')
        .add(newPoint.toDocument());

    final user = await firebaseFirestore.collection('users').doc(userId).get();
    final pointNow = UserModel.fromSnapshot(user).point;
    await firebaseFirestore.collection('users').doc(userId).update(
      {
        'point': pointNow! - point,
      },
    );
  }
}
