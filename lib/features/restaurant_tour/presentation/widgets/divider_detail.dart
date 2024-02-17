import 'package:flutter/material.dart';
import 'package:restaurantour/theme/style.dart';

class DividerDetail extends StatelessWidget {
  const DividerDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1.5,
      color: dividerColor,
    );
  }
}
