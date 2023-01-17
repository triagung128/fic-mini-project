part of 'point_bloc.dart';

abstract class PointEvent extends Equatable {
  const PointEvent();

  @override
  List<Object> get props => [];
}

class OnFetchAllPointsHistory extends PointEvent {}
