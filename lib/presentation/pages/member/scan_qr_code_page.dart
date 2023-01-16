import 'dart:convert';

import 'package:fic_mini_project/common/routes.dart';
import 'package:fic_mini_project/data/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrCodePage extends StatelessWidget {
  const ScanQrCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: MobileScanner(
        allowDuplicates: false,
        onDetect: (barcode, _) {
          final result = barcode.rawValue;
          if (result != null) {
            try {
              final cartMap = jsonDecode(result) as Map<String, dynamic>;
              final cart = CartModel.fromMap(cartMap).toEntity();
              Navigator.pushReplacementNamed(
                context,
                memberCheckoutRoute,
                arguments: cart,
              );
            } catch (e) {
              debugPrint(e.toString());
            }
          }
        },
      ),
    );
  }
}
