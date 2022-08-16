import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import 'user_review_tile.dart';

class UserReviewsList extends StatelessWidget {
  final List<Review>? reviews;
  const UserReviewsList({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: reviews?.length ?? 0,
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) => UserReviewTile(review: reviews?[index]),
      separatorBuilder: (context, index) => Divider(height: 42),
    );
  }
}
