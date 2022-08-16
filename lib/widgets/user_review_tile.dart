import 'package:flutter/material.dart';

import 'stars_widget.dart';

class UserReviewTile extends StatelessWidget {
  const UserReviewTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StarsWidget(starCount: 4),
        SizedBox(height: 12),
        Text("Review text goes here. Review text goes here. This is a review. This is a review that is 3 lines long."),
        SizedBox(height: 12),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(radius: 16),
            SizedBox(width: 8),
            Text("Ammar Hemani"),
          ],
        ),
      ],
    );
  }
}
