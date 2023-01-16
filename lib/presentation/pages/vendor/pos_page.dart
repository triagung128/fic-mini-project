import 'package:fic_mini_project/common/currency_rupiah_extension.dart';
import 'package:fic_mini_project/common/enum_state.dart';
import 'package:fic_mini_project/common/routes.dart';
import 'package:fic_mini_project/common/styles.dart';
import 'package:fic_mini_project/domain/entity/product.dart';
import 'package:fic_mini_project/presentation/blocs/pos/pos_bloc.dart';
import 'package:fic_mini_project/presentation/blocs/product/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PosPage extends StatefulWidget {
  const PosPage({super.key});

  @override
  State<PosPage> createState() => _PosPageState();
}

class _PosPageState extends State<PosPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ProductBloc>().add(OnFetchAllProducts());
      context.read<PosBloc>().add(OnClearCart());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PosBloc, PosState>(
      listener: (context, state) {
        if (state.actionState == PosActionState.success) {
          Navigator.pushReplacementNamed(
            context,
            posCheckoutRoute,
            arguments: {
              'cart': state.cart,
              'cartMap': state.cartMap,
            },
          );
        }
      },
      child: Scaffold(
        backgroundColor: greyColor,
        appBar: AppBar(
          title: const Text('POS Cart'),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProductEmpty) {
              return const Center(
                child: Text('Data Produk Kosong'),
              );
            } else if (state is ProductFailure) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is AllProductsLoaded) {
              return _ListViewPos(products: state.products);
            } else {
              return Container();
            }
          },
        ),
        bottomNavigationBar: const _CustomBottomNavPos(),
      ),
    );
  }
}

class _CustomBottomNavPos extends StatelessWidget {
  const _CustomBottomNavPos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      height: 150,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total'),
              BlocBuilder<PosBloc, PosState>(
                builder: (context, state) {
                  return Text(
                    state.cart.totalPrice.intToFormatRupiah,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          BlocBuilder<PosBloc, PosState>(
            builder: (context, state) {
              return ElevatedButton.icon(
                onPressed: state.cart.products.isEmpty
                    ? null
                    : () => context.read<PosBloc>().add(OnPosAction()),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  fixedSize: Size(MediaQuery.of(context).size.width, 57),
                ),
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Lanjutkan'),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ListViewPos extends StatelessWidget {
  const _ListViewPos({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 8,
        bottom: 24,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        bool visibleCategory = false;

        if (index == 0) {
          visibleCategory = true;
        } else {
          final itemBefore = products[index - 1];

          if (product.category!.id != itemBefore.category!.id) {
            visibleCategory = true;
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (visibleCategory)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  product.category!.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            _PosProductCard(product: product),
          ],
        );
      },
    );
  }
}

class _PosProductCard extends StatelessWidget {
  const _PosProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.memory(
              product.image!,
              width: 108,
              height: 86,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.subtitle2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    product.price.intToFormatRupiah,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: blueColor,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<PosBloc, PosState>(
            builder: (context, state) {
              late Product cartItem;
              final isInCart = state.cart.products
                      .indexWhere((item) => item.id == product.id) !=
                  -1;
              if (isInCart) {
                cartItem = state.cart.products
                    .firstWhere((item) => item.id == product.id);
              }
              return isInCart
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: ElevatedButton(
                              onPressed: () {
                                context
                                    .read<PosBloc>()
                                    .add(OnReduceProductQuantity(product));
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: const Icon(
                                Icons.remove,
                                size: 18,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(cartItem.quantity.toString()),
                          ),
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: ElevatedButton(
                              onPressed: () {
                                context
                                    .read<PosBloc>()
                                    .add(OnAddProductQuantity(product));
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 14),
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<PosBloc>()
                              .add(OnAddProductToCart(product));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Icon(Icons.add),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
