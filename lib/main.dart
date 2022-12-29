import 'package:fic_mini_project/common/routes.dart';
import 'package:fic_mini_project/common/styles.dart';
import 'package:fic_mini_project/firebase_options.dart';
import 'package:fic_mini_project/presentation/blocs/auth/auth_bloc.dart';
import 'package:fic_mini_project/presentation/blocs/profile/profile_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fic_mini_project/injection.dart' as di;
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id_ID', null);

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
        BlocProvider(
          create: (_) => di.locator<ProfileBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Palem Kafe POS App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: whiteColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: textTheme,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: blueColor,
                secondary: navyColor,
              ),
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: whiteColor,
                  statusBarIconBrightness: Brightness.dark,
                ),
                elevation: 0,
                backgroundColor: whiteColor,
                centerTitle: true,
                iconTheme: const IconThemeData(color: blueColor),
                titleTextStyle: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: blueColor, fontWeight: FontWeight.w700),
              ),
        ),
        initialRoute: splashRoute,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
