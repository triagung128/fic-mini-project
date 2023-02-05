import 'package:fic_mini_project/common/routes.dart';
import 'package:fic_mini_project/common/styles.dart';
import 'package:fic_mini_project/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginAsVendorAuthenticated) {
            Navigator.pushNamedAndRemoveUntil(
                context, vendorHomeRoute, (_) => false);
          } else if (state is LoginAsMemberAuthenticated) {
            Navigator.pushNamedAndRemoveUntil(
                context, memberHomeRoute, (_) => false);
          } else if (state is AuthFailure) {
            if (state.message != '') {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
            }
          }
        },
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.only(
              top: 40,
              left: 24,
              right: 24,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Palem Kafe POS App',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: navyColor,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Silahkan login terlebih dahulu sebagai vendor atau member untuk melanjutkan.',
                  ),
                  const SizedBox(height: 80),
                  Center(
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/logo/logo.png'),
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                  _LoginButton(
                    onPressed: state is AuthLoading
                        ? null
                        : () => context
                            .read<AuthBloc>()
                            .add(LoginAsVendorSubmitted()),
                    text: 'Log in as Vendor',
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      'atau',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: navyColor),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _LoginButton(
                    onPressed: state is AuthLoading
                        ? null
                        : () => context
                            .read<AuthBloc>()
                            .add(LoginAsMemberSubmitted()),
                    text: 'Log in as Member',
                  ),
                  state is AuthLoading
                      ? Container(
                          margin: const EdgeInsets.only(top: 24),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width, 57),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: FaIcon(FontAwesomeIcons.google),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
