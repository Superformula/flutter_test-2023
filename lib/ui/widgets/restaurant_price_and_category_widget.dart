import 'package:flutter/material.dart';

import '../../models/restaurant.dart';

class RestaurantPriceAndCategoryWidget extends StatelessWidget {
  const RestaurantPriceAndCategoryWidget(
    this.restaurant, {
    Key? key,
  }) : super(key: key);

  final Restaurant restaurant;

  String get price => restaurant.price ?? '';

  String get displayCategory => restaurant.displayCategory;

  @override
  Widget build(BuildContext context) {
    return Text(price + " " + displayCategory);
  }
}
