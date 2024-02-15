import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ReviewListTile extends StatelessWidget {
  final int stars;
  final String reviewText;
  final String userName;
  final String userImageUrl;

  const ReviewListTile({
    Key? key,
    required this.stars,
    required this.reviewText,
    required this.userName,
    required this.userImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(userImageUrl),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          stars,
          (_) => const Icon(Icons.star, color: Colors.amber, size: 20.0),
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(reviewText),
          const Gap(5),
          Text(userName),
        ],
      ),
    );
  }
}
