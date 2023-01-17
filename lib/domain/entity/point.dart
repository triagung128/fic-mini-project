import 'package:equatable/equatable.dart';

class Point extends Equatable {
  final String userId;
  final int point;
  final bool isEntry;
  final DateTime createdAt;

  const Point({
    required this.userId,
    required this.point,
    required this.isEntry,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [userId, point, isEntry, createdAt];
}
