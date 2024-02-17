import 'dart:math';

import 'package:flutter/material.dart';
import 'package:restaurantour/features/restaurant_tour/models/restaurant.dart';
import 'package:restaurantour/features/restaurant_tour/presentation/widgets/column_builder.dart';
import 'package:restaurantour/features/restaurant_tour/presentation/widgets/divider_detail.dart';
import 'package:restaurantour/features/restaurant_tour/presentation/widgets/open_now_widget.dart';
import 'package:restaurantour/features/restaurant_tour/presentation/widgets/star_rating.dart';
import 'package:restaurantour/theme/style.dart';

class DetailRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  const DetailRestaurant({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          color: defaultTextColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          restaurant.name ?? '',
          style: titleStyle,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border_rounded),
            color: defaultTextColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        backgroundColor: backgroundColor,
      ),
      body: ListView(
        children: [
          Hero(
            tag: 'hero-image:${restaurant.id}',
            child: Image.network(restaurant.heroImage),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          restaurant.price ?? '',
                          style: captionStyle,
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          restaurant.categories?.first.title ?? '',
                          style: captionStyle,
                        ),
                      ],
                    ),
                    OpenNowWidget(restaurant.isOpen),
                  ],
                ),
                const SizedBox(height: 15.0),
                const DividerDetail(),
                const SizedBox(height: 15.0),
                const Text(
                  'Address',
                  style: captionStyle,
                ),
                const SizedBox(height: 15.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        restaurant.location?.formattedAddress ?? '',
                        style: contentSubtitleStyle,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 15.0),
                const DividerDetail(),
                const SizedBox(height: 15.0),
                const Text(
                  'Overall Rating',
                  style: captionStyle,
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      restaurant.rating != null
                          ? restaurant.rating.toString()
                          : '',
                      style: bigTitleStyle,
                    ),
                    const SizedBox(width: 2.5),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Icon(
                        Icons.star,
                        color: starColor,
                        size: 18.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                const DividerDetail(),
                const SizedBox(height: 15.0),
                Text(
                  '${restaurant.reviews != null ? restaurant.reviews?.length.toString() : 0} Reviews',
                  style: captionStyle,
                ),
                const SizedBox(height: 15.0),
                ReviewTile(restaurant: restaurant),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewTile extends StatelessWidget {
  const ReviewTile({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    if (restaurant.reviews != null) {
      return ColumnBuilder(
        itemCount: restaurant.reviews!.length,
        itemBuilder: (context, index) {
          final Review review = restaurant.reviews![index];

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StarRating(
                rating: review.rating != null ? review.rating!.toDouble() : 0.0,
                starSize: 15.0,
              ),
              const SizedBox(height: 5.0),
              Text(getReviewText(), style: contentStyle),
              const SizedBox(height: 5.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    foregroundImage: review.user?.imageUrl != null
                        ? Image.network(review.user!.imageUrl!).image
                        : Image.asset('assets/images/profile-icon.png').image,
                    backgroundColor: backgroundColor,
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    review.user?.name ?? '',
                    style: captionStyle,
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              if (index < (restaurant.reviews!.length - 1))
                const DividerDetail(),
              const SizedBox(height: 5.0),
            ],
          );
        },
      );
    }
    return Container();
  }

  String getReviewText() {
    final random = Random();
    final randomNumber = random.nextInt(3);

    switch (randomNumber) {
      case 0:
        return 'Review text goes here. Review text goes here. This is a review that is 2 lines long.';
      case 1:
        return 'Review text goes here. Review text goes here. This is a review. This is a review that is 3 lines long.';
      case 2:
        return 'Review text goes here. Review text goes here. Review text goes here. This is a review. This is a review. This is a review that is 4 lines long.';
      default:
        return '';
    }
  }
}
