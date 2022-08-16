import 'package:flutter/material.dart';
import 'package:superformula_flutter_test/models/restaurant.dart';

class RestaurantRatings extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantRatings({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Overall Rating"),
        const SizedBox(height: 12),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              (restaurant.rating ?? "N/A").toString(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (restaurant.rating != null) Icon(Icons.star, size: 14, color: Colors.yellow[700]),
          ],
        ),
      ],
    );
  }
}
