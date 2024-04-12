import 'package:flutter/material.dart';
import 'package:restaurantour/widgets/restaurant_item_widget.dart';

class AllRestaurantsView extends StatefulWidget {
  const AllRestaurantsView({Key? key}) : super(key: key);

  @override
  State<AllRestaurantsView> createState() => _AllRestaurantsViewState();
}

class _AllRestaurantsViewState extends State<AllRestaurantsView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100, top: 12),
      itemCount: 10,
      itemBuilder: (context, index) => const BuildRestaurantItem(),
    );
  }
}
