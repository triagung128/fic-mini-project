import 'package:flutter/material.dart';

import 'package:fic_mini_project/common/styles.dart';

class TextFormLabel extends StatelessWidget {
  const TextFormLabel({
    super.key,
    required this.label,
  });

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
