import 'package:fic_mini_project/common/styles.dart';
import 'package:fic_mini_project/domain/entity/category.dart';
import 'package:fic_mini_project/presentation/blocs/category/category_bloc.dart';
import 'package:fic_mini_project/presentation/widgets/action_dialog.dart';
import 'package:fic_mini_project/presentation/widgets/confirm_delete_dialog.dart';
import 'package:fic_mini_project/presentation/widgets/error_dialog.dart';
import 'package:fic_mini_project/presentation/widgets/text_form_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(OnFetchAllCategories());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is CategoryActionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green[400],
              ),
            );
        }

        if (state is CategoryActionFailure) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => ErrorDialog(message: state.message),
          );
        }
      },
      child: Scaffold(
        backgroundColor: greyColor,
        appBar: AppBar(
          title: const Text('Kategori'),
        ),
        body: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (_, state) {
            if (state is CategoryLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CategoryFailure) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is CategoryEmpty) {
              return const Center(
                child: Text('Data Kosong'),
              );
            } else if (state is AllCategoriesLoaded) {
              return ListView.builder(
                itemCount: state.categories.length,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                itemBuilder: (context, index) {
                  return _CategoryCard(category: state.categories[index]);
                },
              );
            } else {
              return Container();
            }
          },
        ),
        floatingActionButton: BlocBuilder<CategoryBloc, CategoryState>(
          buildWhen: (_, current) => current is! CategoryLoading,
          builder: (context, _) {
            return FloatingActionButton(
              onPressed: () => showDialog(
                context: context,
                builder: (_) => const _FormCategory(),
              ),
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onTap: () => showDialog(
          context: context,
          builder: (context) => ActionDialog(
            titleUpdateAction: 'Ubah Kategori',
            updateActionOnTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (_) => _FormCategory(category: category),
              );
            },
            titleDeleteAction: 'Hapus Kategori',
            deleteActionOnTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return ConfirmDeleteDialog(
                    title: 'Hapus Kategori',
                    yesOnPressed: () {
                      Navigator.pop(context);
                      context
                          .read<CategoryBloc>()
                          .add(OnDeleteCategory(category));
                    },
                  );
                },
              );
            },
          ),
        ),
        leading: const FaIcon(FontAwesomeIcons.tags),
        title: Text(category.name),
      ),
    );
  }
}

class _FormCategory extends StatefulWidget {
  const _FormCategory({
    Key? key,
    this.category,
  }) : super(key: key);

  final Category? category;

  @override
  State<_FormCategory> createState() => _FormCategoryState();
}

class _FormCategoryState extends State<_FormCategory> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _isEdit = false;

  @override
  void initState() {
    super.initState();
    _isEdit = widget.category != null;
    _nameController.text = _isEdit ? widget.category!.name : '';
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(
        _isEdit ? 'Ubah Kategori' : 'Tambah Kategori',
        textAlign: TextAlign.center,
      ),
      titlePadding: const EdgeInsets.symmetric(vertical: 24),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextFormLabel(label: 'Nama Kategori'),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan Nama Kategori',
                  ),
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'Nama kategori tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final data = Category(
                id: _isEdit ? widget.category!.id : null,
                name: _nameController.text,
              );

              if (!_isEdit) {
                context.read<CategoryBloc>().add(OnCreateCategory(data));
              } else {
                context.read<CategoryBloc>().add(OnUpdateCategory(data));
              }

              Navigator.pop(context);
            }
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
