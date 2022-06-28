import 'package:flutter/material.dart';
import 'package:restaurantour/ui/values/values.dart';

class PriceCategory extends StatelessWidget {
  final String? price;
  final String category;

  const PriceCategory({Key? key, required this.price, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (price != null)
          Padding(
            padding: const EdgeInsets.only(right: PaddingValues.s),
            child: Text(price!),
          ),
        Text(category, style: Theme.of(context).textTheme.caption),
      ],
    );
  }
}
