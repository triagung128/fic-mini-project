import 'dart:io';

import 'package:fic_mini_project/common/styles.dart';
import 'package:fic_mini_project/domain/entity/user.dart';
import 'package:fic_mini_project/presentation/blocs/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(FetchProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profil'),
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is UpdateProfileFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    state.message,
                    style: whiteTextStyle,
                  ),
                ),
              );
          }

          if (state is UpdateProfileSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: whiteTextStyle,
                  ),
                ),
              );
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          buildWhen: (previous, current) =>
              current is! SelectImageSuccess &&
              current is! UpdateProfileLoading,
          builder: (context, state) {
            if (state is FetchProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FetchProfileSuccess) {
              return _ContentUpdateProfile(user: state.user);
            } else if (state is FetchProfileFailure) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class _ContentUpdateProfile extends StatelessWidget {
  _ContentUpdateProfile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = user.name ?? '';
    _emailController.text = user.email ?? '';
    _phoneNumberController.text = user.phoneNumber ?? '';

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () async {
                  final imagePicker = ImagePicker();
                  await imagePicker
                      .pickImage(source: ImageSource.gallery)
                      .then((image) {
                    if (image != null) {
                      context.read<ProfileBloc>().add(SelectImage(image));
                    }
                  });
                },
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Stack(
                    children: [
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (_, state) {
                          if (state is SelectImageSuccess) {
                            return CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey[300],
                              backgroundImage: FileImage(
                                File(state.image.path),
                              ),
                            );
                          } else {
                            return user.photoUrl != null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey[300],
                                    backgroundImage:
                                        NetworkImage(user.photoUrl!),
                                  )
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey[300],
                                    child: const Icon(Icons.person, size: 48),
                                  );
                          }
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: blueColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: whiteColor,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Form Name
            const _LabelText(text: 'Nama'),
            _CustomTextField(
              controller: _nameController,
              hintText: 'Masukkan Nama',
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 20),
            // Form Email
            const _LabelText(text: 'Email'),
            _CustomTextField(
              controller: _emailController,
              hintText: 'Masukkan Email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            // Form Phone Number
            const _LabelText(text: 'No. Handphone'),
            _CustomTextField(
              controller: _phoneNumberController,
              hintText: 'Masukkan No. Handphone',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 50),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return ElevatedButton.icon(
                  onPressed: state is UpdateProfileLoading
                      ? null
                      : () {
                          final dataInput = User(
                            id: user.id,
                            name: _nameController.text,
                            email: _emailController.text,
                            phoneNumber: _phoneNumberController.text,
                            photoUrl: user.photoUrl,
                          );
                          context
                              .read<ProfileBloc>()
                              .add(UpdateProfile(dataInput));
                        },
                  icon: state is UpdateProfileLoading
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.save),
                  label: Text(
                    'Simpan',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 57),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  const _CustomTextField({
    Key? key,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  final String hintText;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      style: navyTextStyle.copyWith(fontSize: 14),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 21,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.transparent.withOpacity(0.05),
        hintText: hintText,
        hintStyle: navyTextStyle.copyWith(
          fontSize: 14,
          color: navyColor.withOpacity(0.5),
        ),
      ),
    );
  }
}

class _LabelText extends StatelessWidget {
  const _LabelText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: navyTextStyle.copyWith(fontSize: 16),
      ),
    );
  }
}
