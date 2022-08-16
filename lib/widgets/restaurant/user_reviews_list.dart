import 'package:flutter/material.dart';
import 'package:superformula_flutter_test/models/restaurant.dart';
import 'package:superformula_flutter_test/widgets/restaurant/user_review_tile.dart';

class UserReviewsList extends StatelessWidget {
  final Restaurant restaurant;
  const UserReviewsList({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${restaurant.reviews?.length ?? 0} Reviews"),
        SizedBox(height: 12),
        ListView.separated(
          itemCount: restaurant.reviews?.length ?? 0,
          primary: false,
          shrinkWrap: true,
          itemBuilder: (context, index) => UserReviewTile(review: restaurant.reviews?[index]),
          separatorBuilder: (context, index) => Divider(height: 42),
        ),
      ],
    );
  }
}
