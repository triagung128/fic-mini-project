import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Opss.. Error',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.red[400],
            ),
      ),
      content: Text(message),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Oke'),
        ),
      ],
    );
  }
}
