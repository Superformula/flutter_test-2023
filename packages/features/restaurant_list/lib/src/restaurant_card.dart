import 'package:cached_network_image/cached_network_image.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final Function(Restaurant) onRestaurantTapped;
  final Restaurant restaurant;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.onRestaurantTapped,
  });

  // TODO: Add style
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => onRestaurantTapped(restaurant),
        child: SizedBox(
          height: 112.0,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 12.0, 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: SizedBox.square(
                    dimension: 88.0,
                    child: Hero(
                      tag: 'restaurant_${restaurant.id}',
                      child: CachedNetworkImage(
                        imageUrl: restaurant.photoUrl ?? '',
                        errorWidget: (_, __, ___) =>
                            const Icon(Icons.restaurant),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                      child: Text(
                        restaurant.name ?? '',
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${restaurant.price ?? ''} ${restaurant.category ?? ''}',
                              ),
                              Row(
                                children: [
                                  ...List.generate(
                                    restaurant.rating?.ceil() ?? 0,
                                    (index) => const RatingStar(),
                                  ).toList(),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: AvailabilityIndicator(
                              isOpen: restaurant.isOpen ?? false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
