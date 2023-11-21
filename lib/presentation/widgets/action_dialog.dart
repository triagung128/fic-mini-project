import 'package:flutter/material.dart';

class ActionDialog extends StatelessWidget {
  const ActionDialog({
    super.key,
    required this.titleUpdateAction,
    required this.titleDeleteAction,
    required this.updateActionOnTap,
    required this.deleteActionOnTap,
  });

  final String titleUpdateAction;
  final String titleDeleteAction;
  final Function()? updateActionOnTap;
  final Function()? deleteActionOnTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
                onTap: updateActionOnTap,
                title: Text(titleUpdateAction),
                leading: const Icon(Icons.edit),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: deleteActionOnTap,
                title: Text(titleDeleteAction),
                leading: const Icon(Icons.delete_forever),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
