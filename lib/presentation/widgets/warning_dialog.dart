import 'package:flutter/material.dart';

class WarningDialog extends StatelessWidget {
  const WarningDialog({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Oke'),
        ),
      ],
    );
  }
}
