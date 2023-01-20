part of 'report_bloc.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportLoaded extends ReportState {
  final int countTransactions;
  final int turnOverTransactions;

  const ReportLoaded({
    required this.countTransactions,
    required this.turnOverTransactions,
  });

  @override
  List<Object> get props => [countTransactions, turnOverTransactions];
}
