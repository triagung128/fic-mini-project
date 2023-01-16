import 'package:fic_mini_project/common/styles.dart';
import 'package:flutter/material.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Point Saya"),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: navyColor,
            labelPadding: const EdgeInsets.all(16),
            labelStyle: Theme.of(context).textTheme.subtitle1,
            tabs: const [
              Text('Point Masuk'),
              Text('Point Keluar'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                _EntryPoint(),
                _ExitPoint(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EntryPoint extends StatelessWidget {
  const _EntryPoint({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, __) => const Divider(
        thickness: 0.2,
        height: 1,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return ListTile(
          title: const Text('17/02/2023 14:32'),
          trailing: Text(
            '+4100 Points',
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Colors.green[600]),
          ),
        );
      },
    );
  }
}

class _ExitPoint extends StatelessWidget {
  const _ExitPoint({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, __) => const Divider(
        thickness: 0.2,
        height: 1,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return ListTile(
          title: const Text('17/02/2023 14:32'),
          trailing: Text(
            '-4100 Points',
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Colors.red[600]),
          ),
        );
      },
    );
  }
}
