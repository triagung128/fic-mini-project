import 'package:dartz/dartz.dart';
import 'package:fic_mini_project/common/failure.dart';
import 'package:fic_mini_project/domain/entity/point.dart';
import 'package:fic_mini_project/domain/repositories/point_repository.dart';

class GetAllPointsHistory {
  final PointRepository repository;

  GetAllPointsHistory(this.repository);

  Future<Either<Failure, List<Point>>> execute() {
    return repository.getAllPointsHistory();
  }
}
