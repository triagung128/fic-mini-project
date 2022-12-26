import 'package:fic_mini_project/common/routes.dart';
import 'package:fic_mini_project/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberHomePage extends StatelessWidget {
  const MemberHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, loginRoute, (_) => false);
          }
        },
        listenWhen: (previous, current) =>
            previous != current && current is LogoutSuccess,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Member Home Page'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(LogoutRequested());
                  },
                  child: const Text('Logout'),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
