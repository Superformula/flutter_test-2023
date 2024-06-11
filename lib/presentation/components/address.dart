import 'package:flutter/material.dart';
import 'package:restaurantour/data/models/restaurant.dart';

class Address extends StatelessWidget {
  const Address({Key? key, required this.location}) : super(key: key);

  final Location? location;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Address',
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          location?.formattedAddress ?? '',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
