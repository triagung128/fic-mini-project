import 'package:fic_mini_project/common/routes.dart';
import 'package:fic_mini_project/common/styles.dart';
import 'package:fic_mini_project/presentation/blocs/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class MenuModel {
  final Function() onPressed;
  final Widget icon;
  final String labelText;

  MenuModel({
    required this.onPressed,
    required this.icon,
    required this.labelText,
  });
}

class VendorHomePage extends StatefulWidget {
  const VendorHomePage({super.key});

  @override
  State<VendorHomePage> createState() => _VendorHomePageState();
}

class _VendorHomePageState extends State<VendorHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ProfileBloc>().add(OnFetchProfile()));
  }

  @override
  Widget build(BuildContext context) {
    final List<MenuModel> listMenu = [
      MenuModel(
        onPressed: () => Navigator.pushNamed(context, categoryRoute),
        icon: const FaIcon(
          FontAwesomeIcons.tags,
          size: 32,
          color: whiteColor,
        ),
        labelText: 'Kategori',
      ),
      MenuModel(
        onPressed: () => Navigator.pushNamed(context, productRoute),
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
          FontAwesomeIcons.cashRegister,
          size: 32,
          color: whiteColor,
        ),
        labelText: 'Point Of Sales',
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
                  BlocBuilder<ProfileBloc, ProfileState>(
                    buildWhen: (_, current) => current is! ProfileImagePicked,
                    builder: (_, state) {
                      return CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: state is ProfileLoaded
                            ? state.user.photoUrl != null
                                ? NetworkImage(state.user.photoUrl!)
                                : null
                            : null,
                        child: state is ProfileLoaded
                            ? state.user.photoUrl == null
                                ? const Icon(Icons.person)
                                : null
                            : null,
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<ProfileBloc, ProfileState>(
                        buildWhen: (_, current) =>
                            current is! ProfileImagePicked,
                        builder: (_, state) {
                          return Text(
                            state is ProfileLoaded
                                ? 'Hi, ${state.user.name}'
                                : 'Loading...',
                          );
                        },
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('d MMMM yyyy', 'id_ID')
                            .format(DateTime.now()),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: navyColor,
                              fontWeight: FontWeight.w700,
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
                  _SummaryCard(
                    icon: Icons.data_usage,
                    label: 'Total Transaksi',
                    value: '80',
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                'Main Menu',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: navyColor),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(4),
                  itemCount: listMenu.length,
                  itemBuilder: (_, index) {
                    final menuItem = listMenu[index];
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
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: navyColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: icon),
          ),
          const SizedBox(height: 10),
          Text(
            labelText,
            textAlign: TextAlign.center,
          ),
        ],
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
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: whiteColor),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: whiteColor),
          ),
        ],
      ),
    );
  }
}
