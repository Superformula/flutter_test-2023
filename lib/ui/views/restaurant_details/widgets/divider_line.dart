import 'package:flutter/material.dart';
import 'package:restaurantour/ui/values/values.dart';

class DividerLine extends StatelessWidget {
  final EdgeInsetsGeometry? padding;

  const DividerLine({Key? key, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: PaddingValues.xl),
      child: const Divider(thickness: 1.5, height: 0),
    );
  }
}
