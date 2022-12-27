import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:fic_mini_project/domain/entity/user.dart';
import 'package:fic_mini_project/domain/usecases/get_current_user.dart';
import 'package:fic_mini_project/domain/usecases/update_user.dart';
import 'package:fic_mini_project/domain/usecases/update_user_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetCurrentUser getCurrentUser;
  final UpdateUser updateUser;
  final UpdateUserImage updateUserImage;

  XFile? image;

  ProfileBloc({
    required this.getCurrentUser,
    required this.updateUser,
    required this.updateUserImage,
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

      User user = event.user;
      String? imageUrl;

      if (image != null) {
        final fileExtension = image!.name.split('.').last;
        final fileName = 'profile.$fileExtension';
        final file = File(image!.path);

        final uploadImage = await updateUserImage.execute(fileName, file);
        uploadImage.fold(
          (failure) => emit(UpdateProfileFailure(failure.message)),
          (data) => imageUrl = data,
        );
      }

      if (imageUrl != null) {
        user = User(
          id: user.id,
          name: user.name,
          email: user.email,
          phoneNumber: user.phoneNumber,
          photoUrl: imageUrl,
        );
      }

      final result = await updateUser.execute(user);

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
