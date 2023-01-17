import 'package:fic_mini_project/common/routes.dart';
import 'package:fic_mini_project/common/styles.dart';
import 'package:fic_mini_project/data/models/menu_model.dart';
import 'package:fic_mini_project/presentation/blocs/profile/profile_bloc.dart';
import 'package:fic_mini_project/presentation/widgets/menu_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

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
        onPressed: () => Navigator.pushNamed(context, posRoute),
        icon: const FaIcon(
          FontAwesomeIcons.cashRegister,
          size: 32,
          color: whiteColor,
        ),
        labelText: 'POS',
      ),
      MenuModel(
        onPressed: () => Navigator.pushNamed(context, transactionRoute),
        icon: const FaIcon(
          FontAwesomeIcons.database,
          size: 32,
          color: whiteColor,
        ),
        labelText: 'Riwayat\nTransaksi',
      ),
      MenuModel(
        onPressed: () => Navigator.pushNamed(context, profileRoute),
        icon: const FaIcon(
          FontAwesomeIcons.userGear,
          size: 32,
          color: whiteColor,
        ),
        labelText: 'Profil Saya',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Palem Kafe - POS App'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, profileRoute),
                child: Row(
                  children: [
                    BlocBuilder<ProfileBloc, ProfileState>(
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
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: navyColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(
                    flex: 2,
                    child: _SummaryCard(
                      icon: Icons.attach_money,
                      label: 'Omset hari ini',
                      value: 'Rp. 80.000.000',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: _SummaryCard(
                      icon: Icons.data_usage,
                      label: 'Transaksi hari ini',
                      value: '80',
                    ),
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
                    return MenuCard(
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
