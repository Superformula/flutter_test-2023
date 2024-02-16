import 'package:flutter/material.dart';
import 'package:restaurantour/features/restaurant/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurant_details_screen.dart';
import 'package:restaurantour/features/restaurant/presentation/widgets/restaurant_status_widget.dart';
import 'package:restaurantour/features/restaurant/presentation/widgets/star_rating_widget.dart';

class RestaurantListWidget extends StatelessWidget {
  const RestaurantListWidget({
    Key? key,
    required this.restaurants,
  }) : super(key: key);

  final List<RestaurantEntity> restaurants;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemBuilder: (context, index) => _buildRestaurantItemWidget(
        context,
        restaurants[index],
      ),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: restaurants.length,
    );
  }

  Widget _buildRestaurantItemWidget(
    BuildContext context,
    RestaurantEntity restaurant,
  ) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RestaurantDetailsScreen(restaurant: restaurant),
        ),
      ),
      child: Container(
        height: 104,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 2,
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                restaurant.heroImage,
                fit: BoxFit.cover,
                width: 88,
                height: 88,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        restaurant.name ?? "",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${restaurant.price ?? ""} ${restaurant.displayCategory}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StarRatingWidget(rating: restaurant.rating),
                          RestaurantStatusWidget(isOpen: restaurant.isOpen),
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
    );
  }
}
