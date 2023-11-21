import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic_mini_project/common/currency_rupiah_extension.dart';
import 'package:fic_mini_project/common/datetime_extension.dart';
import 'package:fic_mini_project/common/styles.dart';
import 'package:fic_mini_project/domain/entity/transaction.dart';
import 'package:fic_mini_project/presentation/blocs/transaction/transaction_bloc.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(OnFetchAllTransactions());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AllTransactionsLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<TransactionBloc>().add(OnFetchAllTransactions());
              },
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: state.transactions.length,
                itemBuilder: (_, index) {
                  final transaction = state.transactions[index];
                  return _TransactionCard(transaction: transaction);
                },
              ),
            );
          } else if (state is TransactionEmpty) {
            return const Center(
              child: Text('Data Kosong'),
            );
          } else if (state is TransactionFailure) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  const _TransactionCard({
    required this.transaction,
  });

  final TransactionEntity transaction;

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
                transaction.createdAt.dateTimeFormatter,
                style: Theme.of(context).textTheme.bodyLarge,
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
                        .bodyMedium!
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
            transaction.user.name!,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: blueColor),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total :'),
                  const SizedBox(height: 4),
                  Text(
                    transaction.endTotalPrice.intToFormatRupiah,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: blueColor),
                  ),
                ],
              ),
              Text(
                transaction.paymentMethod,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: blueColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
