import 'package:flutter/material.dart';

class MenuModel {
  final Function() onPressed;
  final Widget icon;
  final String labelText;

  MenuModel({
    required this.onPressed,
    required this.icon,
    required this.labelText,
  });
}
