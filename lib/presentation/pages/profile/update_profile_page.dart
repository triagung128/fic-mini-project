import 'dart:io';

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
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ProfileBloc>().add(OnFetchProfile()));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ubah Profil'),
        ),
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdateFailure) {
              _scaffoldMessengerKey.currentState!
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red[400],
                    content: Text(state.message),
                  ),
                );
            }

            if (state is ProfileUpdateSuccess) {
              _scaffoldMessengerKey.currentState!
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green[400],
                    content: Text(state.message),
                  ),
                );
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
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
      ),
    );
  }
}

class _ContentUpdateProfile extends StatefulWidget {
  const _ContentUpdateProfile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<_ContentUpdateProfile> createState() => _ContentUpdateProfileState();
}

class _ContentUpdateProfileState extends State<_ContentUpdateProfile> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  XFile? _imageProfile;

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.user.name ?? '';
    _phoneNumberController.text = widget.user.phoneNumber ?? '';
  }

  @override
  Widget build(BuildContext context) {
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
                  onTap: () async {
                    final imagePicker = ImagePicker();
                    final image = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    if (image != null) {
                      setState(() {
                        _imageProfile = image;
                      });
                    }
                  },
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Stack(
                      children: [
                        _imageProfile != null
                            ? CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey[300],
                                backgroundImage: FileImage(
                                  File(_imageProfile!.path),
                                ),
                              )
                            : widget.user.photoUrl != null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey[300],
                                    backgroundImage:
                                        NetworkImage(widget.user.photoUrl!),
                                  )
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey[300],
                                    child: const Icon(Icons.person, size: 48),
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
                      id: widget.user.id,
                      name: _nameController.text,
                      email: widget.user.email,
                      phoneNumber: _phoneNumberController.text,
                      photoUrl: widget.user.photoUrl,
                      point: widget.user.point,
                    );

                    context
                        .read<ProfileBloc>()
                        .add(OnUpdateProfile(dataInput, _imageProfile));
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
