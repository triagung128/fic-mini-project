import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fic_mini_project/presentation/pages/profile/profile_page.dart';
import 'package:fic_mini_project/presentation/pages/vendor/transaction_page.dart';
import 'package:fic_mini_project/presentation/pages/vendor/vendor_home_page.dart';
import 'package:flutter/material.dart';

class VendorMainPage extends StatefulWidget {
  const VendorMainPage({super.key});

  @override
  State<VendorMainPage> createState() => _VendorMainPageState();
}

class _VendorMainPageState extends State<VendorMainPage> {
  int _bottomNavIndex = 0;

  final List<BottomNavyBarItem> _bottomNavBarItems = [
    BottomNavyBarItem(
      icon: const Icon(Icons.home),
      title: const Text('Beranda'),
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.data_usage),
      title: const Text('Transaksi'),
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.person),
      title: const Text('Profil'),
    ),
  ];

  final List<Widget> _listWidget = [
    const VendorHomePage(),
    const TransactionPage(),
    const ProfilePage(),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _bottomNavIndex,
        children: _listWidget,
      ),
      bottomNavigationBar: BottomNavyBar(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        items: _bottomNavBarItems,
        selectedIndex: _bottomNavIndex,
        onItemSelected: _onBottomNavTapped,
      ),
    );
  }
}
