import 'package:flutter/material.dart';

import 'package:fic_mini_project/domain/entity/cart.dart';
import 'package:fic_mini_project/domain/entity/product.dart';
import 'package:fic_mini_project/presentation/pages/login_page.dart';
import 'package:fic_mini_project/presentation/pages/member/member_checkout_page.dart';
import 'package:fic_mini_project/presentation/pages/member/member_home_page.dart';
import 'package:fic_mini_project/presentation/pages/member/member_point_page.dart';
import 'package:fic_mini_project/presentation/pages/member/member_transaction_page.dart';
import 'package:fic_mini_project/presentation/pages/member/order_success_page.dart';
import 'package:fic_mini_project/presentation/pages/member/scan_qr_code_page.dart';
import 'package:fic_mini_project/presentation/pages/profile/profile_page.dart';
import 'package:fic_mini_project/presentation/pages/profile/update_profile_page.dart';
import 'package:fic_mini_project/presentation/pages/splash_page.dart';
import 'package:fic_mini_project/presentation/pages/vendor/category_page.dart';
import 'package:fic_mini_project/presentation/pages/vendor/pos_checkout_page.dart';
import 'package:fic_mini_project/presentation/pages/vendor/pos_page.dart';
import 'package:fic_mini_project/presentation/pages/vendor/product_add_update_page.dart';
import 'package:fic_mini_project/presentation/pages/vendor/product_page.dart';
import 'package:fic_mini_project/presentation/pages/vendor/transaction_page.dart';
import 'package:fic_mini_project/presentation/pages/vendor/vendor_home_page.dart';

const String splashRoute = '/';
const String loginRoute = '/login';
const String memberHomeRoute = '/member-home';
const String vendorHomeRoute = '/vendor-home';
const String profileRoute = '/profile';
const String updateProfileRoute = '/update-profile';
const String categoryRoute = '/category';
const String productRoute = '/product';
const String productAddUpdateRoute = '/product-add-update';
const String posRoute = '/pos';
const String posCheckoutRoute = '/pos-checkout';
const String transactionRoute = '/transaction';
const String scanQRCodeRoute = '/scan-qr-code';
const String memberCheckoutRoute = '/member-checkout';
const String orderSuccessRoute = '/order-success';
const String memberPointPageRoute = '/member-point';
const String memberTransactionRoute = '/member-transaction';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case memberHomeRoute:
        return MaterialPageRoute(builder: (_) => const MemberHomePage());
      case vendorHomeRoute:
        return MaterialPageRoute(builder: (_) => const VendorHomePage());
      case profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case updateProfileRoute:
        return MaterialPageRoute(builder: (_) => const UpdateProfilePage());
      case categoryRoute:
        return MaterialPageRoute(builder: (_) => const CategoryPage());
      case productRoute:
        return MaterialPageRoute(builder: (_) => const ProductPage());
      case posRoute:
        return MaterialPageRoute(builder: (_) => const PosPage());
      case posCheckoutRoute:
        final args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => PosCheckoutPage(
            cartMap: args['cartMap'],
            cart: args['cart'],
          ),
        );
      case transactionRoute:
        return MaterialPageRoute(builder: (_) => const TransactionPage());
      case scanQRCodeRoute:
        return MaterialPageRoute(builder: (_) => const ScanQrCodePage());
      case memberCheckoutRoute:
        final cart = settings.arguments as Cart;
        return MaterialPageRoute(
          builder: (_) => MemberCheckoutPage(cart: cart),
          settings: settings,
        );
      case productAddUpdateRoute:
        final product = settings.arguments as Product?;
        return MaterialPageRoute(
          builder: (_) => ProductAddUpdatePage(product: product),
          settings: settings,
        );
      case orderSuccessRoute:
        return MaterialPageRoute(builder: (_) => const OrderSuccessPage());
      case memberPointPageRoute:
        return MaterialPageRoute(builder: (_) => const MemberPointPage());
      case memberTransactionRoute:
        return MaterialPageRoute(
          builder: (_) => const MemberTransactionPage(),
        );
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
