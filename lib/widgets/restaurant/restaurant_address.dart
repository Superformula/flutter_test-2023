import 'package:flutter/material.dart';
import 'package:superformula_flutter_test/models/restaurant.dart';

class RestaurantAddress extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantAddress({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Address"),
        SizedBox(height: 12),
        Text(
          restaurant.location?.formattedAddress ?? "N/A",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
