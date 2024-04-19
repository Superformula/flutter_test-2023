import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurantour/common/extensions.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    super.key,
    required this.rating,
    required this.userName,
    required this.userImgUrl,
  });

  final int rating;
  final String userName;
  final String userImgUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RatingBar.builder(
          initialRating: rating.toDouble(),
          direction: Axis.horizontal,
          allowHalfRating: true,
          unratedColor: Colors.amber.withAlpha(50),
          itemCount: 5,
          itemSize: 20,
          ignoreGestures: true,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {},
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            if (userImgUrl.isNotEmpty)
            CachedNetworkImage(
              imageUrl: userImgUrl,
              imageBuilder: (context, imageProvider) => Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (_, __) => const SizedBox(
                height: 80,
                width: 80,
              ),
            ),
            if (userImgUrl.isNotEmpty)
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                userName,
                style: context.theme.textTheme.bodyLarge,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Divider(
          color: Colors.grey.shade200,
          height: 1.5,
        ),
      ],
    );
  }
}
