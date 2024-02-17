import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  const PriceText({Key? key, required this.text}) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? 'Not informed',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );
  }
}
