import 'package:fic_mini_project/data/datasources/point_remote_data_source.dart';
import 'package:fic_mini_project/domain/entity/point.dart';
import 'package:fic_mini_project/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:fic_mini_project/domain/repositories/point_repository.dart';

class PointRepositoryImpl extends PointRepository {
  final PointRemoteDataSource remoteDataSource;

  PointRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Point>>> getAllPointsHistory() async {
    try {
      final result = await remoteDataSource.getAllPointsHistory();
      return Right(result.map((point) => point.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> savePoint(int point) async {
    try {
      final result = await remoteDataSource.savePoint(point);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> usePoint(int point) async {
    try {
      final result = await remoteDataSource.usePoint(point);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
