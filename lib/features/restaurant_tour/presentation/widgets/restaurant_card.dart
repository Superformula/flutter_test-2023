import 'package:flutter/material.dart';
import 'package:restaurantour/features/restaurant_tour/models/restaurant.dart';
import 'package:restaurantour/features/restaurant_tour/presentation/widgets/open_now_widget.dart';
import 'package:restaurantour/features/restaurant_tour/presentation/widgets/restaurant_card_shimmer.dart';
import 'package:restaurantour/features/restaurant_tour/presentation/widgets/star_rating.dart';
import 'package:restaurantour/theme/style.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantCard({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/detail-restaurant',
          arguments: restaurant,
        );
      },
      child: SizedBox(
        height: 125.0,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              8.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Hero(
                        tag: 'hero-image:${restaurant.id}',
                        child: Image.network(
                          restaurant.heroImage,
                          fit: BoxFit.cover,
                          loadingBuilder: ((context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const ShimmerBox(
                              width: 80.0,
                              height: 80.0,
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: subtitleStyle,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
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
                          const SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              restaurant.rating != null
                                  ? StarRating(
                                      rating: restaurant.rating!,
                                      starSize: 15.0,
                                    )
                                  : Container(),
                              OpenNowWidget(restaurant.isOpen),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
