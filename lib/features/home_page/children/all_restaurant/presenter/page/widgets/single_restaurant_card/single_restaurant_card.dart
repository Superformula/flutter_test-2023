import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurantour/core/models/restaurant.dart';
import 'package:restaurantour/features/home_page/children/all_restaurant/presenter/page/widgets/single_restaurant_card/status_indicator.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/presenter/bloc/favorite_restaurants_bloc.dart';
import 'package:restaurantour/shared/widgets/rating_stars.dart';

class SingleRestaurantCard extends StatelessWidget {
  const SingleRestaurantCard({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed('restaurant-page', extra: restaurant).then((result) {
          if (result == true) {
            context.read<FavoriteRestaurantsBloc>().add(const InitialEvent());
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 8,
        ),
        child: Card(
          child: IntrinsicHeight(
            child: Row(
              children: [
                Hero(
                  tag: 'restaurant-image-${restaurant.id}',
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 90,
                      height: 90,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          imageUrl: restaurant.photos!.first,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name ?? 'No name provided',
                          maxLines: 2,
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Row(
                            children: [
                              Text(
                                restaurant.price ?? '',
                                style: Theme.of(context).textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(
                                  restaurant.categories?.first.title ?? '',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            RatingStars(
                              rate: restaurant.rating ?? 0.0,
                              starSize: 20.0,
                              color: Colors.amber,
                            ),
                            const Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: restaurant.isOpen
                                  ? const StatusIndicator(
                                      text: "Open Now",
                                      color: Colors.green,
                                    )
                                  : const StatusIndicator(
                                      text: "Closed",
                                      color: Colors.red,
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
