import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({Key? key, required this.text}) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? 'unkown',
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}
