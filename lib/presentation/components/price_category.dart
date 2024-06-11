import 'package:flutter/material.dart';

class PriceCategory extends StatelessWidget {
  const PriceCategory({
    Key? key,
    this.price,
    required this.category,
  }) : super(key: key);

  final String? price;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${price ?? ''} $category',
      style: const TextStyle(fontSize: 12),
    );
  }
}
