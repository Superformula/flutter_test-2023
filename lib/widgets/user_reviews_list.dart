import 'package:flutter/material.dart';

import 'user_review_tile.dart';

class UserReviewsList extends StatelessWidget {
  const UserReviewsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 4,
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) => UserReviewTile(),
      separatorBuilder: (context, index) => Divider(height: 42),
    );
  }
}
