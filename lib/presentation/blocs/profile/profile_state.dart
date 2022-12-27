part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class FetchProfileLoading extends ProfileState {}

class FetchProfileFailure extends ProfileState {
  final String message;

  const FetchProfileFailure(this.message);

  @override
  List<Object> get props => [message];
}

class FetchProfileSuccess extends ProfileState {
  final User user;

  const FetchProfileSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class UpdateProfileLoading extends ProfileState {}

class UpdateProfileFailure extends ProfileState {
  final String message;

  const UpdateProfileFailure(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateProfileSuccess extends ProfileState {
  final String message;

  const UpdateProfileSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class SelectImageSuccess extends ProfileState {
  final XFile image;

  const SelectImageSuccess(this.image);

  @override
  List<Object?> get props => [image];
}
