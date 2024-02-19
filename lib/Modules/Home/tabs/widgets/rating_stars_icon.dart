import 'package:flutter/material.dart';

class RatingStarsIcon extends StatelessWidget {
  const RatingStarsIcon({Key? key, required this.amount}) : super(key: key);

  final double amount;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      for (int i = 0; i < amount; i++)
        const Icon(
          Icons.star,
          size: 14,
          color: Color.fromARGB(255, 255, 205, 40),
        ),
    ]);
  }
}
