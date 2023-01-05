import 'package:fic_mini_project/common/currency_input_formatter.dart';
import 'package:fic_mini_project/common/currency_rupiah_extension.dart';
import 'package:fic_mini_project/common/styles.dart';
import 'package:fic_mini_project/domain/entity/category.dart';
import 'package:fic_mini_project/domain/entity/product.dart';
import 'package:fic_mini_project/presentation/blocs/category/category_bloc.dart';
import 'package:fic_mini_project/presentation/blocs/product/product_bloc.dart';
import 'package:fic_mini_project/presentation/widgets/error_dialog.dart';
import 'package:fic_mini_project/presentation/widgets/text_form_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductAddUpdatePage extends StatefulWidget {
  const ProductAddUpdatePage({
    super.key,
    required this.product,
  });

  final Product? product;

  @override
  State<ProductAddUpdatePage> createState() => _ProductAddUpdatePageState();
}

class _ProductAddUpdatePageState extends State<ProductAddUpdatePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  Category? _categorySelected;
  bool _isEdit = false;

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(OnFetchAllCategories());

    _isEdit = widget.product != null;

    if (_isEdit) {
      _nameController.text = widget.product!.name;
      _priceController.text = widget.product!.price.intToFormatRupiah;
      _categorySelected = widget.product!.category;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductActionSuccess) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green[400],
                  ),
                );
            }

            if (state is ProductActionFailure) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => ErrorDialog(message: state.message),
              );
            }
          },
        ),
        BlocListener<CategoryBloc, CategoryState>(
          listener: (context, state) {
            if (state is CategoryEmpty) {
              _showAlertEmptyCategory(context);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isEdit ? 'Edit Produk' : 'Tambah Produk'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextFormLabel(label: 'Nama Produk'),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan Nama Produk',
                    ),
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Nama Produk tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const TextFormLabel(label: 'Harga'),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan Harga',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyInputFormatter(),
                    ],
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Harga tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const TextFormLabel(label: 'Kategori'),
                  const SizedBox(height: 10),
                  BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (_, state) {
                      if (state is AllCategoriesLoaded) {
                        return DropdownButtonFormField(
                          borderRadius: BorderRadius.circular(16),
                          hint: const Text('Pilih Kategori'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          value: widget.product != null
                              ? widget.product!.category
                              : null,
                          items: state.categories
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              _categorySelected = value;
                            }
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Kategori belum dipilih';
                            }
                            return null;
                          },
                        );
                      }

                      return const Text('Kategori masih kosong.');
                    },
                  ),
                  const SizedBox(height: 20),
                  const TextFormLabel(label: 'Foto Produk'),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: navyColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Gambar masih kosong'),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: navyColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Pilih Foto'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      if (_categorySelected != null) {
                        if (_formKey.currentState!.validate()) {
                          final product = Product(
                            id: _isEdit ? widget.product!.id : null,
                            name: _nameController.text,
                            price: _priceController.text.formatRupiahToInt,
                            category: _categorySelected!,
                          );

                          if (_isEdit) {
                            context
                                .read<ProductBloc>()
                                .add(OnUpdateProduct(product));
                          } else {
                            context
                                .read<ProductBloc>()
                                .add(OnCreateProduct(product));
                          }
                        } else {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: const Text('Lengkapi isian form!'),
                                backgroundColor: Colors.red[400],
                              ),
                            );
                        }
                      } else {
                        _showAlertEmptyCategory(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 57),
                    ),
                    child: const Text('Simpan'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAlertEmptyCategory(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Kategori Masih Kosong'),
        content: const Text(
          'Harap isikan kategori terlebih dahulu di menu kategori',
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Oke'),
          ),
        ],
      ),
    );
  }
}
