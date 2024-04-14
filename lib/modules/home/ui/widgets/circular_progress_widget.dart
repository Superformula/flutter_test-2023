import 'package:flutter/material.dart';
import 'package:restaurantour/core/utils/constants.dart';

class CircularProgressWidget extends StatelessWidget {
  const CircularProgressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      key: Key(ConstantsApp.kLoading),
      child: CircularProgressIndicator(strokeWidth: 4.0),
    );
  }
}
