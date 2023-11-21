import 'package:flutter/material.dart';

class WarningDialog extends StatelessWidget {
  const WarningDialog({
    super.key,
    required this.title,
    required this.description,
  });

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
