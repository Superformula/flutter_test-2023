import 'package:flutter/material.dart';

import '../utils/colors.dart';

class PaddedDivider extends StatelessWidget {
  const PaddedDivider({
    Key? key,
    this.vertical = 24,
  }) : super(key: key);

  final double vertical;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical),
      child: const Divider(
        color: AppColors.gray,
      ),
    );
  }
}
