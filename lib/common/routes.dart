import 'package:fic_mini_project/presentation/pages/login_page.dart';
import 'package:fic_mini_project/presentation/pages/member/member_home_page.dart';
import 'package:fic_mini_project/presentation/pages/splash_page.dart';
import 'package:fic_mini_project/presentation/pages/vendor/vendor_home_page.dart';
import 'package:flutter/material.dart';

const String splashRoute = '/';
const String loginRoute = '/login';
const String vendorHomeRoute = '/vendor-home';
const String memberHomeRoute = '/member-home';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case vendorHomeRoute:
        return MaterialPageRoute(builder: (_) => const VendorHomePage());
      case memberHomeRoute:
        return MaterialPageRoute(builder: (_) => const MemberHomePage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page Not Found :('),
            ),
          ),
        );
    }
  }
}
