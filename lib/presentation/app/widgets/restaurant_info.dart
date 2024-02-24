import 'package:flutter/material.dart';
import 'package:restaurantour/presentation/app/helpers/helpers.dart';

class RestaurantInfo extends StatelessWidget {
  const RestaurantInfo({
    required this.price,
    required this.category,
    super.key,
  });

  final String price;
  final String category;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.theme;
    final typography = appTheme.typography;

    return Text(
      '$price $category',
      style: typography.caption1,
    );
  }
}
