import 'package:flutter/material.dart';

class CategorieText extends StatelessWidget {
  const CategorieText({Key? key, required this.text}) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      ' ' + (text ?? ''),
      style: const TextStyle(
        fontSize: 12,
      ),
    );
  }
}
