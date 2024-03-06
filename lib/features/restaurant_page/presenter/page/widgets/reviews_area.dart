import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurantour/core/models/restaurant.dart';
import 'package:restaurantour/shared/widgets/rating_stars.dart';

class ReviewsArea extends StatelessWidget {
  const ReviewsArea({
    super.key,
    required this.reviews,
  });

  final List<Review>? reviews;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text('Reviews ${reviews?.length ?? 0}'),
            ),
            if (reviews != null)
              for (Review review in reviews!)
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child:
                            RatingStars(rate: review.rating?.toDouble() ?? 0.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          review.text ?? '',
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: review.user?.imageUrl ??
                                    'https://fakeimg.pl/600x400',
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.network(
                                  'https://fakeimg.pl/600x400',
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Text(review.user?.name ?? ''),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Container(
                          color: Colors.grey.shade300,
                          height: 1,
                          width: MediaQuery.sizeOf(context).width * 0.9,
                        ),
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ],
    );
  }
}
