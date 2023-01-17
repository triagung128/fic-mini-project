part of 'point_bloc.dart';

abstract class PointState extends Equatable {
  const PointState();

  @override
  List<Object> get props => [];
}

class PointInitial extends PointState {}

class PointLoading extends PointState {}

class AllPointsLoaded extends PointState {
  final List<Point> points;

  const AllPointsLoaded(this.points);

  @override
  List<Object> get props => [points];
}

class PointFailure extends PointState {
  final String message;

  const PointFailure(this.message);

  @override
  List<Object> get props => [message];
}
