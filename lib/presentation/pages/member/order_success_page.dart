import 'package:avatar_glow/avatar_glow.dart';
import 'package:fic_mini_project/common/styles.dart';
import 'package:flutter/material.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff1488CC),
                Color(0xff2B32B2),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    SizedBox(
                      height: 161,
                      width: 161,
                      child: AvatarGlow(
                        glowColor: Colors.blue,
                        endRadius: 80,
                        child: Material(
                          elevation: 8,
                          shape: const CircleBorder(),
                          child: CircleAvatar(
                            radius: 50,
                            child: Image.asset('assets/success_order.png'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Selamat',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: blueColor,
                            fontWeight: FontWeight.w700,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Transaksi Anda Telah Berhasil !',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: blueColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: whiteColor,
                    width: 2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  fixedSize: Size(MediaQuery.of(context).size.width, 57),
                ),
                child: Text(
                  'Kembali Ke Beranda',
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: whiteColor),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  fixedSize: Size(MediaQuery.of(context).size.width, 57),
                ),
                child: Text(
                  'Lihat Riwayat Transaksi',
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: blueColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
