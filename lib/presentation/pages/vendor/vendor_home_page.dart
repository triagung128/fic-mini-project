import 'package:fic_mini_project/common/styles.dart';
import 'package:fic_mini_project/data/models/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VendorHomePage extends StatelessWidget {
  VendorHomePage({super.key});

  final List<MenuModel> _listMenu = [
    MenuModel(
      onPressed: () {},
      icon: const FaIcon(
        FontAwesomeIcons.mugHot,
        size: 32,
        color: whiteColor,
      ),
      labelText: 'Produk',
    ),
    MenuModel(
      onPressed: () {},
      icon: const FaIcon(
        FontAwesomeIcons.tags,
        size: 32,
        color: whiteColor,
      ),
      labelText: 'Kategori',
    ),
    MenuModel(
      onPressed: () {},
      icon: const FaIcon(
        FontAwesomeIcons.cashRegister,
        size: 32,
        color: whiteColor,
      ),
      labelText: 'POS',
    ),
    MenuModel(
      onPressed: () {},
      icon: const FaIcon(
        FontAwesomeIcons.qrcode,
        size: 32,
        color: whiteColor,
      ),
      labelText: 'Scan QR Code',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundColor: whiteColor,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, Nama Anda',
                        style: navyTextStyle,
                      ),
                      Text(
                        '03 November 2022',
                        style: navyTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(
                    child: _SummaryCard(
                      icon: Icons.attach_money,
                      label: 'Total Omset',
                      value: 'Rp. 80.000.000',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _SummaryCard(
                      icon: Icons.bar_chart_rounded,
                      label: 'Total Transaksi',
                      value: '80',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                'Main Menu',
                style: navyTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.9,
                  ),
                  padding: const EdgeInsets.all(4),
                  itemCount: _listMenu.length,
                  itemBuilder: (context, index) {
                    final menuItem = _listMenu[index];
                    return _MenuCard(
                      onPressed: menuItem.onPressed,
                      icon: menuItem.icon,
                      labelText: menuItem.labelText,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.labelText,
  }) : super(key: key);

  final Function() onPressed;
  final Widget icon;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: navyColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: icon),
            ),
            const SizedBox(height: 16),
            Text(
              labelText,
              style: navyTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: blueColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.transparent.withOpacity(0.3),
            child: Icon(icon, color: whiteColor),
          ),
          const SizedBox(height: 16),
          Text(
            label,
            style: whiteTextStyle.copyWith(
              fontWeight: bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: whiteTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
          ),
        ],
      ),
    );
  }
}
