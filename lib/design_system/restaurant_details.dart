import 'package:flutter/material.dart';

class RestaurantDetails extends StatelessWidget {
  final String price;
  final String category;

  const RestaurantDetails({
    Key? key,
    required this.price,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(price),
        const SizedBox(width: 4),
        Text(category),
      ],
    );
  }
}
