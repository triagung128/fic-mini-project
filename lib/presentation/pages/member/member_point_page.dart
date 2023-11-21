import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic_mini_project/common/datetime_extension.dart';
import 'package:fic_mini_project/common/point_extension.dart';
import 'package:fic_mini_project/common/styles.dart';
import 'package:fic_mini_project/domain/entity/point.dart';
import 'package:fic_mini_project/presentation/blocs/point/point_bloc.dart';

class MemberPointPage extends StatefulWidget {
  const MemberPointPage({super.key});

  @override
  State<MemberPointPage> createState() => _MemberPointPageState();
}

class _MemberPointPageState extends State<MemberPointPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );

    Future.microtask(
      () => context.read<PointBloc>().add(OnFetchAllPointsHistory()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Points"),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: navyColor,
            labelStyle: Theme.of(context).textTheme.titleMedium,
            tabs: [
              Tab(
                text: 'Point Masuk',
                icon: Icon(
                  Icons.arrow_downward,
                  size: 18,
                  color: Colors.green[600],
                ),
              ),
              Tab(
                text: 'Point Keluar',
                icon: Icon(
                  Icons.arrow_upward,
                  size: 18,
                  color: Colors.red[600],
                ),
              ),
            ],
          ),
          Expanded(
            child: BlocBuilder<PointBloc, PointState>(
              builder: (context, state) {
                if (state is PointLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is AllPointsLoaded) {
                  final entryPoints = state.points
                      .where((item) => item.isEntry == true)
                      .toList();

                  final exitPoints = state.points
                      .where((item) => item.isEntry == false)
                      .toList();

                  return TabBarView(
                    controller: _tabController,
                    children: [
                      _ListViewPoint(points: entryPoints),
                      _ListViewPoint(points: exitPoints),
                    ],
                  );
                } else if (state is PointFailure) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}

class _ListViewPoint extends StatelessWidget {
  const _ListViewPoint({
    required this.points,
  });

  final List<Point> points;

  @override
  Widget build(BuildContext context) {
    return points.isEmpty
        ? const Center(
            child: Text('Data Kosong'),
          )
        : ListView.separated(
            separatorBuilder: (_, __) => const Divider(
              thickness: 0.2,
              height: 1,
            ),
            itemCount: points.length,
            itemBuilder: (context, index) {
              final point = points[index];
              return ListTile(
                title: Text(point.createdAt.dateTimeFormatter),
                trailing: Text(
                  points.first.isEntry == true
                      ? '+${point.point.pointFormatter} Points'
                      : '-${point.point.pointFormatter} Points',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: points.first.isEntry == true
                            ? Colors.green[600]
                            : Colors.red[600],
                      ),
                ),
              );
            },
          );
  }
}
