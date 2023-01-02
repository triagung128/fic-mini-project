import 'package:fic_mini_project/common/styles.dart';
import 'package:fic_mini_project/domain/entity/category.dart';
import 'package:fic_mini_project/presentation/blocs/category/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(OnFetchAllCategoryEvent());
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
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
                backgroundColor: Colors.green,
              ),
            );
        }

        if (state is CategoryActionFailure) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Text(state.message),
            ),
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
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Text(state.message),
                ),
              );
            } else if (state is CategoryEmpty) {
              return const Padding(
                padding: EdgeInsets.all(24),
                child: Center(
                  child: Text('Data Kosong'),
                ),
              );
            } else if (state is FetchAllCategorySuccess) {
              return ListView.builder(
                itemCount: state.listCategory.length,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                itemBuilder: (context, index) {
                  final category = state.listCategory[index];
                  return _CategoryCard(
                    category: category,
                    nameController: _nameController,
                  );
                },
              );
            } else {
              return Container();
            }
          },
        ),
        floatingActionButton: BlocBuilder<CategoryBloc, CategoryState>(
          buildWhen: (previous, current) => current is! CategoryLoading,
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                _showFormCategory(
                  context: context,
                  nameController: _nameController,
                  isEdit: false,
                );
              },
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
    required this.nameController,
  }) : super(key: key);

  final Category category;
  final TextEditingController nameController;

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
          vertical: 14,
          horizontal: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 42,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: const Text('Aksi'),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          _showFormCategory(
                            context: context,
                            nameController: nameController,
                            isEdit: true,
                            category: category,
                          );
                        },
                        title: const Text('Ubah Kategori'),
                        leading: const Icon(Icons.edit),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          _showConfirmDeleteCategory(context, category.id!);
                        },
                        title: const Text('Hapus Kategori'),
                        leading: const Icon(Icons.delete_forever),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        leading: const FaIcon(FontAwesomeIcons.tags),
        title: Text(category.name),
      ),
    );
  }
}

Future<void> _showFormCategory({
  required BuildContext context,
  required TextEditingController nameController,
  required bool isEdit,
  Category? category,
}) {
  if (isEdit) {
    nameController.text = category!.name;
  } else {
    nameController.text = '';
  }

  final formKey = GlobalKey<FormState>();

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(
        isEdit ? 'Ubah Kategori' : 'Tambah Kategori',
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: navyColor, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan Nama',
                  ),
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'Nama tidak boleh kosong';
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
          onPressed: () {
            Navigator.pop(context);
            formKey.currentState!.reset();
          },
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            final isValidForm = formKey.currentState!.validate();
            if (isValidForm) {
              Navigator.pop(context);
              final categoryBloc = context.read<CategoryBloc>();
              if (!isEdit) {
                final insertCategory = Category(
                  id: null,
                  name: nameController.text,
                );
                categoryBloc.add(OnInsertUpdateCategoryEvent(
                  category: insertCategory,
                  isUpdate: false,
                ));
              } else {
                final updateCategory = Category(
                  id: category!.id,
                  name: nameController.text,
                );
                categoryBloc.add(OnInsertUpdateCategoryEvent(
                  category: updateCategory,
                  isUpdate: true,
                ));
              }
              formKey.currentState!.reset();
            }
          },
          child: const Text('Simpan'),
        ),
      ],
    ),
  );
}

Future<void> _showConfirmDeleteCategory(BuildContext context, int categoryId) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Hapus Kategori',
          style:
              Theme.of(context).textTheme.headline6!.copyWith(color: navyColor),
        ),
        icon: const Icon(
          Icons.delete_forever,
          color: Colors.red,
        ),
        content: const Text(
          'Apakah Anda ingin menghapus ?',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tidak'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context
                  .read<CategoryBloc>()
                  .add(OnRemoveCategoryEvent(categoryId));
            },
            child: const Text('Ya'),
          ),
        ],
      );
    },
  );
}
