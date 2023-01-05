import 'package:fic_mini_project/common/styles.dart';
import 'package:flutter/material.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  const ConfirmDeleteDialog({
    Key? key,
    required this.yesOnPressed,
    required this.title,
  }) : super(key: key);

  final Function()? yesOnPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        title,
        style:
            Theme.of(context).textTheme.headline6!.copyWith(color: navyColor),
      ),
      icon: Icon(
        Icons.delete_forever,
        color: Colors.red[400],
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
          onPressed: yesOnPressed,
          child: const Text('Ya'),
        ),
      ],
    );
  }
}
