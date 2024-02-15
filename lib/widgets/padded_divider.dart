import 'package:flutter/material.dart';

import '../utils/colors.dart';

class PaddedDivider extends StatelessWidget {
  const PaddedDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Divider(
        color: AppColors.gray,
      ),
    );
  }
}
