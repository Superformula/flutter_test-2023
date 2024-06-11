import 'package:flutter/material.dart';
import 'package:restaurantour/core/design_system/widgets/open_status_widget.dart';
import 'package:restaurantour/core/design_system/widgets/rating_widget.dart';
import 'package:restaurantour/features/restaurant/domain/models/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailPage({required this.restaurant, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name ?? 'Restaurant Name'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          Image.network(
            restaurant.heroImage,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${restaurant.price ?? ''} ${restaurant.displayCategory}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    OpenStatus(isOpen: restaurant.isOpen),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Address',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(restaurant.location?.formattedAddress ?? ''),
                const SizedBox(height: 16),
                const Text(
                  'Overall Rating',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      '${restaurant.rating ?? 0}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 24,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '${restaurant.reviews?.length ?? 0} Reviews',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Column(
                  children: restaurant.reviews?.map((review) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RatingWidget(rating: restaurant.rating ?? 0),
                              const SizedBox(height: 4),
                              Text(
                                review.id ?? 'Review ID',
                                maxLines: review.rating,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      review.user?.imageUrl ?? '',
                                    ),
                                    radius: 12,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(review.user?.name ?? 'User Name'),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList() ??
                      [],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
