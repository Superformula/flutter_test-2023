import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/screens/restaurant_detail_screen.dart';
import 'package:restaurantour/widgets/restaurant_card_widget.dart';

class BuildRestaurantItem extends StatelessWidget {
  const BuildRestaurantItem({
    Key? key,
    required this.restaurantData,
  }) : super(key: key);
  final Restaurant restaurantData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantDetailScreen(
              restaurantId: restaurantData.id!,
            ),
          ),
        );
      },
      child: RestaurantCardWidget(
        restaurantData: restaurantData,
      ),
    );
  }
}
