import 'package:flutter/material.dart';
import 'package:restaurantour/presentation/utils/color_util.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: ColorUtil.dividerLine,
      height: 24,
      thickness: 1,
    );
  }
}
