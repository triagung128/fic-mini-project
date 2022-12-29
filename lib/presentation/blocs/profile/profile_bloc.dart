import 'package:equatable/equatable.dart';
import 'package:fic_mini_project/domain/entity/user.dart';
import 'package:fic_mini_project/domain/usecases/get_current_user.dart';
import 'package:fic_mini_project/domain/usecases/update_current_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetCurrentUser getCurrentUser;
  final UpdateCurrentUser updateCurrentUser;

  XFile? image;

  ProfileBloc({
    required this.getCurrentUser,
    required this.updateCurrentUser,
  }) : super(ProfileInitial()) {
    on<FetchProfile>((event, emit) async {
      emit(FetchProfileLoading());

      final result = await getCurrentUser.execute();

      result.fold(
        (failure) => emit(FetchProfileFailure(failure.message)),
        (data) => emit(FetchProfileSuccess(data)),
      );
    });

    on<UpdateProfile>((event, emit) async {
      emit(UpdateProfileLoading());

      final result = await updateCurrentUser.execute(event.user, image);

      result.fold(
        (failure) => emit(UpdateProfileFailure(failure.message)),
        (successMessage) => emit(UpdateProfileSuccess(successMessage)),
      );

      add(FetchProfile());
    });

    on<SelectImage>((event, emit) {
      image = event.image;
      emit(SelectImageSuccess(event.image));
    });
  }
}
