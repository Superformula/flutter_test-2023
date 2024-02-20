import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final double rating;

  const RatingWidget({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overall Rating',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Text(
              rating.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            const SizedBox(width: 3.0),
            const Icon(
              Icons.star,
              color: Colors.amber,
              size: 16.0,
            ),
          ],
        ),
      ],
    );
  }
}
