import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:fic_mini_project/domain/entity/point.dart';

class PointModel extends Equatable {
  final String userId;
  final int point;
  final bool isEntry;
  final DateTime createdAt;

  const PointModel({
    required this.userId,
    required this.point,
    required this.isEntry,
    required this.createdAt,
  });

  factory PointModel.fromSnapshot(DocumentSnapshot doc) => PointModel(
        userId: doc.get('user_id'),
        point: doc.get('point'),
        isEntry: doc.get('is_entry'),
        createdAt: DateTime.parse(doc.get('created_at')),
      );

  Map<String, dynamic> toDocument() => {
        'user_id': userId,
        'point': point,
        'is_entry': isEntry,
        'created_at': createdAt.toIso8601String(),
      };

  Point toEntity() => Point(
        userId: userId,
        point: point,
        isEntry: isEntry,
        createdAt: createdAt,
      );

  @override
  List<Object?> get props => [userId, point, isEntry, createdAt];
}
