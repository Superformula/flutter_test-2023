import 'package:flutter/material.dart';

class OverallRating extends StatelessWidget {
  const OverallRating({Key? key, this.rating}) : super(key: key);

  final double? rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overall Rating',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Text(
              (rating ?? 0.0).toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(
              Icons.star,
              color: Colors.amber,
              size: 16,
            ),
          ],
        ),
      ],
    );
  }
}
