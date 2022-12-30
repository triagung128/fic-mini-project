import 'package:fic_mini_project/common/styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.keyboardType,
    required this.controller,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: navyColor, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 21,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.transparent.withOpacity(0.05),
            hintText: hintText,
            hintStyle: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: navyColor.withOpacity(0.5)),
          ),
        ),
      ],
    );
  }
}
