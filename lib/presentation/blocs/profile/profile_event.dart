part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class OnFetchProfile extends ProfileEvent {}

class OnUpdateProfile extends ProfileEvent {
  final User user;
  final XFile? image;

  const OnUpdateProfile(this.user, this.image);

  @override
  List<Object?> get props => [user, image];
}
