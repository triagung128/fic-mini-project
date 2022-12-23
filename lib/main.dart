import 'package:fic_mini_project/common/styles.dart';
import 'package:fic_mini_project/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Palem Cafe',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: blueColor,
              secondary: navyColor,
            ),
        scaffoldBackgroundColor: whiteColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: whiteColor,
          centerTitle: true,
          titleTextStyle: blueTextStyle.copyWith(
            fontSize: 22,
            fontWeight: medium,
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
