import 'package:flutter/material.dart';
import 'package:restaurantour/design_system/open_status_indicator.dart';
import 'package:restaurantour/design_system/restaurant_details.dart';

class RestaurantListTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String priceRange;
  final String category;
  final double rating;
  final bool isOpen;
  final VoidCallback? onTap;

  const RestaurantListTile({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.priceRange,
    required this.category,
    required this.rating,
    required this.isOpen,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: Image.network(
            imageUrl,
            width: 88,
            height: 88,
            fit: BoxFit.cover,
          ),
          title: Text(name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RestaurantDetails(
                price: priceRange,
                category: category,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _StarRating(rating: rating),
                  OpenStatusIndicator(isOpen: isOpen),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StarRating extends StatelessWidget {
  final double rating;

  const _StarRating({
    Key? key,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) {
          if (index < rating.round()) {
            return const Icon(
              Icons.star,
              color: Colors.amber,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
