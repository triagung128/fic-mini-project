import 'package:fic_mini_project/common/styles.dart';
import 'package:flutter/material.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
        ),
        itemCount: 20,
        itemBuilder: (context, index) {
          return const _TransactionCard();
        },
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  const _TransactionCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '22/07/2023 15:32',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline_rounded,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Selesai',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.green),
                  ),
                ],
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(thickness: 0.2, height: 1),
          ),
          const Text('Nama Member :'),
          const SizedBox(height: 4),
          Text(
            'Rahmat',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: blueColor),
          ),
          const SizedBox(height: 16),
          const Text('Total :'),
          const SizedBox(height: 4),
          Text(
            'Rp. 15.000',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: blueColor),
          ),
        ],
      ),
    );
  }
}
