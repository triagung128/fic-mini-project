part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final User user;

  const UpdateProfile(this.user);

  @override
  List<Object> get props => [user];
}

class SelectImage extends ProfileEvent {
  final XFile image;

  const SelectImage(this.image);

  @override
  List<Object> get props => [image];
}
