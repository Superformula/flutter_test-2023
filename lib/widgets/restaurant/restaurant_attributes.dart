import 'package:flutter/material.dart';
import 'package:superformula_flutter_test/models/restaurant.dart';

class RestaurantAttributes extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantAttributes({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${restaurant.price ?? ""} ${restaurant.categories?[0].title ?? ""}",
      style: const TextStyle(fontSize: 13),
    );
  }
}
