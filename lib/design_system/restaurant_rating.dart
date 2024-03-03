import 'package:flutter/material.dart';

class RestaurantRating extends StatelessWidget {
  const RestaurantRating({
    Key? key,
    required this.rating,
  }) : super(key: key);
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overall Rating:',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Text(
              rating.toString(),
              style: const TextStyle(
                fontSize: 28,
                fontFamily: 'Lora',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            const Icon(
              Icons.star,
              color: Colors.amber,
            ),
          ],
        ),
      ],
    );
  }
}
