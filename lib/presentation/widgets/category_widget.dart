import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  // final Restaurant restaurant;

  final String? price;
  final String category;

  const CategoryWidget({Key? key, this.price, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (price != null) Text(price!, style: const TextStyle(fontSize: 12)),
        if (price != null) const SizedBox(width: 4),
        Text(category, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
