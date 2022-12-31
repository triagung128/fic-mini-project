import 'package:fic_mini_project/presentation/pages/login_page.dart';
import 'package:fic_mini_project/presentation/pages/member/member_home_page.dart';
import 'package:fic_mini_project/presentation/pages/profile/update_profile_page.dart';
import 'package:fic_mini_project/presentation/pages/splash_page.dart';
import 'package:fic_mini_project/presentation/pages/vendor/category_page.dart';
import 'package:fic_mini_project/presentation/pages/vendor/vendor_main_page.dart';
import 'package:flutter/material.dart';

const String splashRoute = '/';
const String loginRoute = '/login';
const String vendorMainRoute = '/vendor-main';
const String memberHomeRoute = '/member-home';
const String updateProfileRoute = '/update-profile';
const String categoryRoute = 'category';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case vendorMainRoute:
        return MaterialPageRoute(builder: (_) => const VendorMainPage());
      case memberHomeRoute:
        return MaterialPageRoute(builder: (_) => const MemberHomePage());
      case updateProfileRoute:
        return MaterialPageRoute(builder: (_) => const UpdateProfilePage());
      case categoryRoute:
        return MaterialPageRoute(builder: (_) => const CategoryPage());
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
