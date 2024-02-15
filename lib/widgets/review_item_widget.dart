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
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          stars,
          (_) => const Icon(Icons.star, color: Colors.amber, size: 20.0),
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              "Review text goes here. Review text goes here. Review text goes here. This is a review. This is a review. This is a review that is 4 lines long."),
          const Gap(5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(userImageUrl),
              ),
              const Gap(5),
              Text(userName),
            ],
          ),
        ],
      ),
    );
  }
}
