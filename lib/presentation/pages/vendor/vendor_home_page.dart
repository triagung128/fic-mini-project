import 'package:flutter/material.dart';

class VendorHomePage extends StatelessWidget {
  const VendorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda'),
      ),
      body: const Center(
        child: Text('Vendor Home Page'),
      ),
    );
  }
}
