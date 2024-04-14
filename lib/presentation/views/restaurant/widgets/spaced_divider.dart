import 'package:flutter/material.dart';

class SpacedDivider extends StatelessWidget {
  final double padding;
  const SpacedDivider({
    Key? key,
    this.padding = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: padding),
        const Divider(color: Colors.black26),
        SizedBox(height: padding),
      ],
    );
  }
}
