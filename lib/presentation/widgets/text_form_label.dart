import 'package:fic_mini_project/common/styles.dart';
import 'package:flutter/material.dart';

class TextFormLabel extends StatelessWidget {
  const TextFormLabel({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: navyColor, fontWeight: FontWeight.w700),
    );
  }
}
