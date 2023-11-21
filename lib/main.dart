import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:fic_mini_project/common/routes.dart';
import 'package:fic_mini_project/common/styles.dart';
import 'package:fic_mini_project/firebase_options.dart';
import 'package:fic_mini_project/injection.dart' as di;
import 'package:fic_mini_project/presentation/blocs/auth/auth_bloc.dart';
import 'package:fic_mini_project/presentation/blocs/category/category_bloc.dart';
import 'package:fic_mini_project/presentation/blocs/point/point_bloc.dart';
import 'package:fic_mini_project/presentation/blocs/pos/pos_bloc.dart';
import 'package:fic_mini_project/presentation/blocs/product/product_bloc.dart';
import 'package:fic_mini_project/presentation/blocs/profile/profile_bloc.dart';
import 'package:fic_mini_project/presentation/blocs/report/report_bloc.dart';
import 'package:fic_mini_project/presentation/blocs/transaction/transaction_bloc.dart';

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
        BlocProvider(
          create: (_) => di.locator<CategoryBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<ProductBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PosBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PointBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TransactionBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<ReportBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Palem Kafe POS App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
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
                    .titleLarge!
                    .copyWith(color: blueColor, fontWeight: FontWeight.w700),
              ),
          inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
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
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: navyColor.withOpacity(0.5)),
              ),
        ),
        initialRoute: splashRoute,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
