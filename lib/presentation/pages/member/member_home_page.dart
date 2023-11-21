import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:fic_mini_project/common/point_extension.dart';
import 'package:fic_mini_project/common/routes.dart';
import 'package:fic_mini_project/common/styles.dart';
import 'package:fic_mini_project/data/models/menu_model.dart';
import 'package:fic_mini_project/presentation/blocs/profile/profile_bloc.dart';
import 'package:fic_mini_project/presentation/widgets/menu_card.dart';

class MemberHomePage extends StatefulWidget {
  const MemberHomePage({super.key});

  @override
  State<MemberHomePage> createState() => _MemberHomePageState();
}

class _MemberHomePageState extends State<MemberHomePage> {
  final images = [
    'assets/banner_promo/promo_1.png',
    'assets/banner_promo/promo_2.jpg',
    'assets/banner_promo/promo_3.jpg',
    'assets/banner_promo/promo_4.jpg',
    'assets/banner_promo/promo_5.jpg',
  ];

  int _currentIndexImage = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ProfileBloc>().add(OnFetchProfile()));
  }

  @override
  Widget build(BuildContext context) {
    final List<MenuModel> listMenu = [
      MenuModel(
        onPressed: () => Navigator.pushNamed(context, scanQRCodeRoute),
        icon: const FaIcon(
          FontAwesomeIcons.qrcode,
          size: 32,
          color: whiteColor,
        ),
        labelText: 'Scan QR Code',
      ),
      MenuModel(
        onPressed: () => Navigator.pushNamed(context, memberTransactionRoute),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
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
              Text(
                'Promo Spesial',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              CarouselSlider(
                items: images
                    .map((image) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: AssetImage(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 150,
                  initialPage: 0,
                  autoPlay: true,
                  viewportFraction: 1,
                  onPageChanged: (index, _) {
                    setState(() {
                      _currentIndexImage = index;
                    });
                  },
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: images
                    .asMap()
                    .entries
                    .map((image) => Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: navyColor.withOpacity(
                              _currentIndexImage == image.key ? 0.9 : 0.4,
                            ),
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 32),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return ListTile(
                    onTap: state is ProfileLoaded
                        ? () =>
                            Navigator.pushNamed(context, memberPointPageRoute)
                        : null,
                    tileColor: blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    leading: const FaIcon(
                      FontAwesomeIcons.wallet,
                      color: whiteColor,
                    ),
                    title: Text(
                      'Points Kamu',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: whiteColor),
                    ),
                    trailing: Text(
                      state is ProfileLoaded
                          ? '${state.user.point?.pointFormatter} Points'
                          : 'Loading...',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: whiteColor),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  'Main Menu',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: navyColor),
                ),
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
