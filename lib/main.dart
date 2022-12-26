import 'package:fic_mini_project/common/routes.dart';
import 'package:fic_mini_project/common/styles.dart';
import 'package:fic_mini_project/firebase_options.dart';
import 'package:fic_mini_project/presentation/blocs/auth/auth_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fic_mini_project/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  di.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<AuthBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Palem Kafe - POS App',
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: blueColor,
                secondary: navyColor,
              ),
          scaffoldBackgroundColor: whiteColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            elevation: 2,
            color: whiteColor,
            centerTitle: true,
            titleTextStyle: blueTextStyle.copyWith(
              fontSize: 22,
              fontWeight: medium,
            ),
          ),
        ),
        initialRoute: splashRoute,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
