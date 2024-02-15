import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 36,
        width: 36,
        child: CircularProgressIndicator(
          color: AppColors.black,
          strokeCap: StrokeCap.round,
        ),
      ),
    );
  }
}
