import 'package:flutter/material.dart';
import 'package:superformula_flutter_test/models/restaurant.dart';
import 'package:superformula_flutter_test/widgets/general/stars_widget.dart';

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
        if (review?.text != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(review?.text ?? ""),
          ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (review?.user?.imageUrl != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(review?.user?.imageUrl ?? ""),
                ),
              ),
            Text(review?.user?.name ?? "N/A"),
          ],
        ),
      ],
    );
  }
}
