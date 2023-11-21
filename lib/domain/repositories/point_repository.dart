import 'package:dartz/dartz.dart';

import 'package:fic_mini_project/common/failure.dart';
import 'package:fic_mini_project/domain/entity/point.dart';

abstract class PointRepository {
  Future<Either<Failure, List<Point>>> getAllPointsHistory();
  Future<Either<Failure, void>> savePoint(int point);
  Future<Either<Failure, void>> usePoint(int point);
}
