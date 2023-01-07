import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:fic_mini_project/common/styles.dart';
import 'package:fic_mini_project/domain/entity/user.dart';
import 'package:fic_mini_project/presentation/blocs/profile/profile_bloc.dart';
import 'package:fic_mini_project/presentation/widgets/text_form_label.dart';
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
    Future.microtask(() => context.read<ProfileBloc>().add(OnFetchProfile()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Profil'),
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdateFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red[400],
                  content: Text(state.message),
                ),
              );
          }

          if (state is ProfileUpdateSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green[400],
                  content: Text(state.message),
                ),
              );
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          buildWhen: (_, current) => current is! ProfileImagePicked,
          builder: (_, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProfileLoaded) {
              return _ContentUpdateProfile(user: state.user);
            } else if (state is ProfileFailure) {
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _nameController.text = user.name ?? '';
    _emailController.text = user.email ?? '';
    _phoneNumberController.text = user.phoneNumber ?? '';

    XFile? imageProfile;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    context.read<ProfileBloc>().add(OnPickProfileImage());
                  },
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Stack(
                      children: [
                        BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (_, state) {
                            if (state is ProfileImagePicked) {
                              imageProfile = state.image;
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
              const TextFormLabel(label: 'Nama'),
              const SizedBox(height: 10),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Masukkan Nama',
                ),
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const TextFormLabel(label: 'Email'),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Masukkan Email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  if (value != null && !EmailValidator.validate(value)) {
                    return 'Email tidak valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const TextFormLabel(label: 'No. Handphone'),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  hintText: 'Masukkan No. Handphone',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'No. Handphone tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final dataInput = User(
                      id: user.id,
                      name: _nameController.text,
                      email: _emailController.text,
                      phoneNumber: _phoneNumberController.text,
                      photoUrl: user.photoUrl,
                    );
                    context
                        .read<ProfileBloc>()
                        .add(OnUpdateProfile(dataInput, imageProfile));
                  } else {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: const Text(
                            'Harap lengkapi isian form !',
                          ),
                          backgroundColor: Colors.red[400],
                        ),
                      );
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Simpan'),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 57),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
