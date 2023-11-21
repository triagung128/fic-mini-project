import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:fic_mini_project/common/currency_input_formatter.dart';
import 'package:fic_mini_project/common/currency_rupiah_extension.dart';
import 'package:fic_mini_project/common/styles.dart';
import 'package:fic_mini_project/domain/entity/category.dart';
import 'package:fic_mini_project/domain/entity/product.dart';
import 'package:fic_mini_project/presentation/blocs/category/category_bloc.dart';
import 'package:fic_mini_project/presentation/blocs/product/product_bloc.dart';
import 'package:fic_mini_project/presentation/widgets/error_dialog.dart';
import 'package:fic_mini_project/presentation/widgets/text_form_label.dart';
import 'package:fic_mini_project/presentation/widgets/warning_dialog.dart';

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
  Uint8List? _imageProduct;

  bool _isEdit = false;

  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => context.read<CategoryBloc>().add(OnFetchAllCategories()),
    );

    _isEdit = widget.product != null;

    if (_isEdit) {
      _nameController.text = widget.product!.name;
      _priceController.text = widget.product!.price.intToFormatRupiah;
      _categorySelected = widget.product!.category;
      _imageProduct = widget.product!.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductActionSuccess) {
              Navigator.pop(context);
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
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const WarningDialog(
                  title: 'Kategori Masih Kosong',
                  description:
                      'Harap isikan kategori terlebih dahulu di menu kategori',
                ),
              );
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
                      return DropdownButtonFormField(
                        borderRadius: BorderRadius.circular(16),
                        hint: state is AllCategoriesLoaded
                            ? const Text('Pilih Kategori')
                            : const Text('Data Kategori Kosong'),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        value: widget.product?.category,
                        items: state is AllCategoriesLoaded
                            ? state.categories
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name),
                                  ),
                                )
                                .toList()
                            : null,
                        onChanged: (value) {
                          if (value != null) _categorySelected = value;
                        },
                        validator: (value) {
                          if (value == null) return 'Kategori belum dipilih';
                          return null;
                        },
                      );
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
                        _imageProduct != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.memory(
                                  _imageProduct!,
                                  width: 63,
                                  height: 63,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Text('Gambar masih kosong'),
                        ElevatedButton(
                          onPressed: () async {
                            final imagePicker = ImagePicker();
                            final image = await imagePicker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              final imageBytes = await image.readAsBytes();
                              setState(() {
                                _imageProduct = imageBytes;
                              });
                            }
                          },
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
                      if (_formKey.currentState!.validate()) {
                        if (_imageProduct == null) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => const WarningDialog(
                              title: 'Foto produk belum dipilih',
                              description:
                                  'Harap pilih foto produk terlebih dahulu',
                            ),
                          );
                        } else {
                          final product = Product(
                            id: _isEdit ? widget.product!.id : null,
                            name: _nameController.text,
                            price: _priceController.text.formatRupiahToInt,
                            category: _categorySelected!,
                            image: _imageProduct!,
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
                        }
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

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
