import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

// TODO: Move this widget to restaurant list feature, it's not reused anywhere else
// TODO: What should be in the component library: rating_star, availability_indicator
class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({super.key, required this.restaurant});

  // TODO: Add text styles
  @override
  Widget build(BuildContext context) {
    return Card(
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
                      errorWidget: (_, __, ___) => const Icon(Icons.restaurant),
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
                                  (index) => const Icon(
                                    Icons.star,
                                    color: Color(0XFFFFB800),
                                    size: 12.0,
                                  ),
                                ).toList(),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              restaurant.isOpen ?? false
                                  ? 'Open Now'
                                  : 'Closed',
                            ),
                            Icon(
                              Icons.circle,
                              color: restaurant.isOpen ?? false
                                  ? Colors.green
                                  : Colors.red,
                              size: 8.0,
                            ),
                            const SizedBox(width: 8.0),
                          ],
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
    );
  }
}
