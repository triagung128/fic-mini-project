import 'package:fic_mini_project/common/currency_rupiah_extension.dart';
import 'package:fic_mini_project/common/datetime_extension.dart';
import 'package:fic_mini_project/common/styles.dart';
import 'package:fic_mini_project/domain/entity/transaction.dart';
import 'package:fic_mini_project/presentation/blocs/transaction/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberTransactionPage extends StatefulWidget {
  const MemberTransactionPage({super.key});

  @override
  State<MemberTransactionPage> createState() => _MemberTransactionPageState();
}

class _MemberTransactionPageState extends State<MemberTransactionPage> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(OnFetchAllTransactionsByUserId());
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
            return ListView.builder(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
              ),
              itemCount: state.transactions.length,
              itemBuilder: (_, index) {
                final transaction = state.transactions[index];
                return _MemberTransactionCard(transaction: transaction);
              },
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

class _MemberTransactionCard extends StatelessWidget {
  const _MemberTransactionCard({Key? key, required this.transaction})
      : super(key: key);

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
          const Text('Total :'),
          const SizedBox(height: 4),
          Text(
            transaction.endTotalPrice.intToFormatRupiah,
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
