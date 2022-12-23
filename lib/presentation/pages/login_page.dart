import 'package:fic_mini_project/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
      ),
      body: Container(
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
                'Palm Cafe POS',
                style: navyTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: medium,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Silahkan login terlebih dahulu sebagai vendor atau member untuk melanjutkan.',
                style: navyTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  width: 162,
                  height: 187,
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {},
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
                      child: FaIcon(FontAwesomeIcons.googlePlusG),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Log in as Vendor',
                        textAlign: TextAlign.center,
                        style: whiteTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  'atau',
                  style: navyTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {},
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
                      child: FaIcon(FontAwesomeIcons.googlePlusG),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Log in as Member',
                        textAlign: TextAlign.center,
                        style: whiteTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
