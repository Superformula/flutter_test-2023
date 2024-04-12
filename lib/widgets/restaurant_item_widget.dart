import 'package:flutter/material.dart';
import 'package:restaurantour/screens/restaurant_detail_screen.dart';
import 'package:restaurantour/widgets/restaurant_card_widget.dart';

class BuildRestaurantItem extends StatelessWidget {
  const BuildRestaurantItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RestaurantDetailScreen(
              //TODO: send restaurant id
              restaurantId: 'dummy_id',
            ),
          ),
        );
      },
      child: const RestaurantCardWidget(),
    );
  }
}
