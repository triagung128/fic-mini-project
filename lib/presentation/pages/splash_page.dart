import 'package:fic_mini_project/common/routes.dart';
import 'package:fic_mini_project/common/styles.dart';
import 'package:fic_mini_project/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(LoadLoginStatus());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginStatusLoaded) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              state.status == true
                  ? state.role == AuthBloc.roleVendor
                      ? vendorHomeRoute
                      : memberHomeRoute
                  : loginRoute,
              (_) => false,
            );
          }
        },
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo.png', width: 180),
                const SizedBox(height: 16),
                Text(
                  'Palem Kafe - POS App',
                  style: navyTextStyle.copyWith(
                    fontSize: 22,
                    fontWeight: bold,
                  ),
                ),
                const SizedBox(height: 32),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
