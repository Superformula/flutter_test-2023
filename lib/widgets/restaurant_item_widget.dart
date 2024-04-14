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
        //Navigate to the restaurant's details screen on tap
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantDetailScreen(
              //In case no id is given (might never happen)
              restaurantId: restaurantData.id ?? 'noId',
            ),
          ),
        );
      },
      //Widget used to build UI
      child: RestaurantCardWidget(
        restaurantData: restaurantData,
      ),
    );
  }
}
