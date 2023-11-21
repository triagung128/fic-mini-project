import 'package:dartz/dartz.dart';

import 'package:fic_mini_project/common/failure.dart';
import 'package:fic_mini_project/domain/repositories/point_repository.dart';

class SavePoint {
  final PointRepository repository;

  SavePoint(this.repository);

  Future<Either<Failure, void>> execute(int point) {
    return repository.savePoint(point);
  }
}
