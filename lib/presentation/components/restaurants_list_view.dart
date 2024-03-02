import 'dart:math';

import 'package:flutter/material.dart';
import 'package:restaurantour/data/models/restaurant.dart';

class RestaurantsListView extends StatelessWidget {
  const RestaurantsListView({
    Key? key,
    required this.restaurants,
  }) : super(key: key);

  final List<Restaurant> restaurants;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurants.length,
      padding: const EdgeInsets.symmetric(vertical: 5),
      itemBuilder: (context, index) {
        final restaurant = restaurants[index];

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 2,
          ),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        restaurant.heroImage,
                        height: 84,
                        width: 84,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              restaurant.name ?? '',
                              style: const TextStyle(fontSize: 18),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${restaurant.price ?? ''} ${restaurant.displayCategory}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Row(
                                children: [
                                  for (var i = 0;
                                      i <
                                          min(
                                            restaurant.rating?.round() ?? 0,
                                            5,
                                          );
                                      i++)
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                  const Spacer(),
                                  Text(
                                    restaurant.isOpen ? 'Open Now' : 'Closed',
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: restaurant.isOpen
                                          ? Colors.green
                                          : Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const SizedBox.square(
                                      dimension: 7,
                                    ),
                                  ),
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
      },
    );
  }
}
