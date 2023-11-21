import 'package:flutter/material.dart';

import 'package:fic_mini_project/common/styles.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.labelText,
  });

  final Function() onPressed;
  final Widget icon;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: navyColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: icon),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 30,
            child: Text(
              labelText,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
