import 'package:fic_mini_project/common/routes.dart';
import 'package:fic_mini_project/common/styles.dart';
import 'package:fic_mini_project/domain/entity/user.dart';
import 'package:fic_mini_project/presentation/blocs/auth/auth_bloc.dart';
import 'package:fic_mini_project/presentation/blocs/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(FetchProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, loginRoute, (_) => false);
          }
        },
        listenWhen: (previous, current) {
          return previous != current && current is LogoutSuccess;
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
              return _ContentProfile(user: state.user);
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

class _ContentProfile extends StatelessWidget {
  const _ContentProfile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              user.photoUrl != null
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user.photoUrl!),
                      backgroundColor: Colors.grey[300],
                    )
                  : CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      child: const Icon(Icons.person, size: 48),
                    ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.name}',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: navyColor,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${user.email}',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: navyColor),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
          _ListMenuProfile(
            onPressed: () {
              Navigator.pushNamed(context, updateProfileRoute);
            },
            text: 'Ubah Profil',
          ),
          const SizedBox(height: 16),
          _ListMenuProfile(
            onPressed: () => _showConfirmLogout(context),
            text: 'Logout',
          ),
        ],
      ),
    );
  }
}

class _ListMenuProfile extends StatelessWidget {
  const _ListMenuProfile({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Text(
        text,
        style:
            Theme.of(context).textTheme.bodyText2!.copyWith(color: whiteColor),
      ),
      iconColor: whiteColor,
      trailing: const Icon(Icons.arrow_forward_ios),
      tileColor: blueColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

Future<void> _showConfirmLogout(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Logout',
          style:
              Theme.of(context).textTheme.headline6!.copyWith(color: navyColor),
        ),
        icon: const Icon(Icons.logout),
        content: Text(
          'Apakah Anda ingin logout ?',
          textAlign: TextAlign.center,
          style:
              Theme.of(context).textTheme.bodyText2!.copyWith(color: navyColor),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Ya',
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: whiteColor),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Tidak',
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: whiteColor),
            ),
          ),
        ],
      );
    },
  );
}
