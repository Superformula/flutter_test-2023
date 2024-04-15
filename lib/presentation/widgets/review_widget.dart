import 'package:flutter/material.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/presentation/widgets/stars_widget.dart';

class ReviewWidget extends StatelessWidget {
  final Review review;

  const ReviewWidget({Key? key, required this.review}) : super(key: key);

  List<Widget> _buildText() {
    if (review.text == null) return [];
    return [
      Text(review.text!, style: const TextStyle(fontSize: 16)),
      const SizedBox(height: 8),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StarsWidget(rating: review.rating!.toDouble()),
        const SizedBox(height: 8),
        ..._buildText(),
        Row(
          children: [
            CircleAvatar(
              child: Text(review.user!.name![0]),
              radius: 20,
              foregroundImage: NetworkImage(review.user!.imageUrl ?? ''),
            ),
            const SizedBox(width: 8),
            Text(review.user!.name ?? '', style: const TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }
}
