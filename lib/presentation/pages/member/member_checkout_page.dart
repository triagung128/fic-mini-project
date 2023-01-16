import 'package:fic_mini_project/common/currency_rupiah_extension.dart';
import 'package:fic_mini_project/common/routes.dart';
import 'package:fic_mini_project/common/styles.dart';
import 'package:fic_mini_project/domain/entity/cart.dart';
import 'package:flutter/material.dart';

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
  final List<String> _paymentMethods = ['TUNAI', 'OVO', 'DANA', 'GOPAY'];
  String _selectedPaymentMethod = 'TUNAI';
  bool _usePoints = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      appBar: AppBar(
        title: const Text('Checkout Pesanan'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
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
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    const Divider(thickness: 0.2),
                    ListView.separated(
                      itemCount: widget.cart.products.length,
                      shrinkWrap: true,
                      separatorBuilder: (_, __) =>
                          const Divider(thickness: 0.2),
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
                                .bodyText2!
                                .copyWith(color: blueColor),
                          ),
                          trailing: Text('${product.quantity} items'),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
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
                          style: Theme.of(context).textTheme.bodyText2,
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
                    ListTile(
                      title: const Text('Gunakan Points'),
                      subtitle: Text(
                        'Points Anda : 1000 Points',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: blueColor),
                      ),
                      trailing: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: _usePoints,
                          borderRadius: BorderRadius.circular(16),
                          dropdownColor: whiteColor,
                          style: Theme.of(context).textTheme.bodyText2,
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
                            setState(() {
                              _usePoints = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Get Point (10%)'),
                      trailing: Text(
                          '${(widget.cart.totalPrice * 0.1).toInt()} Points'),
                    ),
                    if (_usePoints)
                      const ListTile(
                        title: Text('Potong Points'),
                        trailing: Text('- Rp. 5.000'),
                      ),
                    const Divider(thickness: 0.2, height: 1),
                    ListTile(
                      title: const Text('Total'),
                      trailing: Text(widget.cart.totalPrice.intToFormatRupiah),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: whiteColor,
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.pushReplacementNamed(context, orderSuccessRoute);
          },
          icon: const Icon(Icons.arrow_forward),
          label: const Text('Proses Pesanan'),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(MediaQuery.of(context).size.width, 57),
            backgroundColor: Colors.green,
          ),
        ),
      ),
    );
  }
}
