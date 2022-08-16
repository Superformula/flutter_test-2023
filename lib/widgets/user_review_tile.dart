import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import 'stars_widget.dart';

class UserReviewTile extends StatelessWidget {
  final Review? review;
  const UserReviewTile({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StarsWidget(starCount: review?.rating?.round() ?? 0),
        SizedBox(height: 12),
        Text("Dummy review text since API doesn't have a field that returns review text"),
        SizedBox(height: 12),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (review?.user?.imageUrl != null) ...[
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(review?.user?.imageUrl ?? ""),
              ),
              SizedBox(width: 8),
            ],
            Text(review?.user?.name ?? "N/A"),
          ],
        ),
      ],
    );
  }
}
