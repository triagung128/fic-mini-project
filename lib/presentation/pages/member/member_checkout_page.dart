import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic_mini_project/common/currency_rupiah_extension.dart';
import 'package:fic_mini_project/common/point_extension.dart';
import 'package:fic_mini_project/common/routes.dart';
import 'package:fic_mini_project/common/styles.dart';
import 'package:fic_mini_project/domain/entity/cart.dart';
import 'package:fic_mini_project/domain/entity/transaction.dart';
import 'package:fic_mini_project/domain/entity/user.dart';
import 'package:fic_mini_project/presentation/blocs/profile/profile_bloc.dart';
import 'package:fic_mini_project/presentation/blocs/transaction/transaction_bloc.dart';

class MemberCheckoutPage extends StatefulWidget {
  const MemberCheckoutPage({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  State<MemberCheckoutPage> createState() => _MemberCheckoutPageState();
}

class _MemberCheckoutPageState extends State<MemberCheckoutPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(OnFetchProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      appBar: AppBar(
        title: const Text('Checkout Pesanan'),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (_, state) {
          if (state is ProfileLoaded) {
            return _ContentMemberCheckout(
              cart: widget.cart,
              user: state.user,
            );
          } else if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text('Oppss.. Sepertinya Error.\nSilahkan Dicoba Lagi'),
            );
          }
        },
      ),
    );
  }
}

class _ContentMemberCheckout extends StatefulWidget {
  const _ContentMemberCheckout({
    required this.cart,
    required this.user,
  });

  final Cart cart;
  final User user;

  @override
  State<_ContentMemberCheckout> createState() => _ContentMemberCheckoutState();
}

class _ContentMemberCheckoutState extends State<_ContentMemberCheckout> {
  final List<String> _paymentMethods = ['TUNAI', 'OVO', 'DANA', 'GOPAY'];

  late String _selectedPaymentMethod;
  int _usedPoints = 0;
  int _endTotal = 0;
  bool _isUsedPoints = false;

  @override
  void initState() {
    super.initState();

    _selectedPaymentMethod = _paymentMethods[0];
    _endTotal = widget.cart.totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    listOrder() {
      return Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Daftar Pesanan',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Divider(thickness: 0.2),
            ListView.separated(
              itemCount: widget.cart.products.length,
              shrinkWrap: true,
              separatorBuilder: (_, __) => const Divider(thickness: 0.2),
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 16),
              itemBuilder: (context, index) {
                final product = widget.cart.products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(
                    product.price.intToFormatRupiah,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: blueColor),
                  ),
                  trailing: Text('${product.quantity} items'),
                );
              },
            ),
          ],
        ),
      );
    }

    payment() {
      return Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            ListTile(
              title: const Text('Metode Pembayaran'),
              trailing: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: _selectedPaymentMethod,
                  borderRadius: BorderRadius.circular(16),
                  style: Theme.of(context).textTheme.bodyMedium,
                  items: _paymentMethods
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
              ),
            ),
            const Divider(thickness: 0.2, height: 1),
            if (widget.user.point != 0)
              ListTile(
                title: const Text('Gunakan Points'),
                subtitle: Text(
                  'Points Anda : ${widget.user.point?.pointFormatter} Points',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: blueColor),
                ),
                trailing: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: _isUsedPoints,
                    borderRadius: BorderRadius.circular(16),
                    dropdownColor: whiteColor,
                    style: Theme.of(context).textTheme.bodyMedium,
                    items: const [
                      DropdownMenuItem(
                        value: true,
                        child: Text('YA'),
                      ),
                      DropdownMenuItem(
                        value: false,
                        child: Text('TIDAK'),
                      ),
                    ],
                    onChanged: (value) {
                      final cartTotalPrice = widget.cart.totalPrice;
                      final nowPoint = widget.user.point!;

                      setState(() {
                        _isUsedPoints = value!;

                        if (_isUsedPoints) {
                          if (nowPoint > cartTotalPrice) {
                            _usedPoints = cartTotalPrice;
                          } else {
                            _usedPoints = nowPoint;
                          }
                          _endTotal = cartTotalPrice - _usedPoints;
                        } else {
                          _usedPoints = 0;
                          _endTotal = cartTotalPrice;
                        }
                      });
                    },
                  ),
                ),
              ),
          ],
        ),
      );
    }

    total() {
      return Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            ListTile(
              title: const Text('Get Point (10%)'),
              trailing: Text(
                '${(widget.cart.totalPrice * 0.1).toInt().pointFormatter} Points',
              ),
            ),
            if (_isUsedPoints)
              ListTile(
                title: const Text('Potong Points'),
                trailing: Text('- ${_usedPoints.pointFormatter}'),
              ),
            const Divider(thickness: 0.2, height: 1),
            ListTile(
              title: const Text('Total'),
              trailing: Text(_endTotal.intToFormatRupiah),
            ),
          ],
        ),
      );
    }

    buttonTransaction() {
      return Container(
        color: whiteColor,
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          onPressed: () {
            final dataTransaction = TransactionEntity(
              user: widget.user,
              cart: widget.cart,
              usePoint: _usedPoints,
              endTotalPrice: _endTotal,
              paymentMethod: _selectedPaymentMethod,
              createdAt: DateTime.now(),
            );

            context
                .read<TransactionBloc>()
                .add(OnSaveTransaction(dataTransaction));
          },
          icon: const Icon(Icons.arrow_forward),
          label: const Text('Proses Pesanan'),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(MediaQuery.of(context).size.width, 57),
            backgroundColor: Colors.green,
          ),
        ),
      );
    }

    buttonTransactionLoading() {
      return Container(
        color: whiteColor,
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            fixedSize: Size(MediaQuery.of(context).size.width, 57),
            backgroundColor: Colors.green,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(),
              ),
              SizedBox(width: 12),
              Text('Proses Pesanan'),
            ],
          ),
        ),
      );
    }

    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state is TransactionSuccess) {
          Navigator.pushReplacementNamed(context, orderSuccessRoute);
        }
      },
      child: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (_, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        listOrder(),
                        const SizedBox(height: 24),
                        payment(),
                        const SizedBox(height: 24),
                        total(),
                      ],
                    ),
                  ),
                ),
              ),
              state is TransactionLoading
                  ? buttonTransactionLoading()
                  : buttonTransaction(),
            ],
          );
        },
      ),
    );
  }
}
