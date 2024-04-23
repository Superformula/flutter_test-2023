import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: SizedBox.square(
              dimension: 88.0,
              child: CachedNetworkImage(
                imageUrl: restaurant.photoUrl ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  restaurant.name ?? '',
                  maxLines: 2,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          '${restaurant.price ?? ''} ${restaurant.category ?? ''}'),
                      Row(
                        children: [
                          ...List.generate(
                            restaurant.rating?.truncate() ?? 0,
                            (index) => const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 12.0,
                            ),
                          ).toList(),
                          const Expanded(child: SizedBox(height: 0)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
