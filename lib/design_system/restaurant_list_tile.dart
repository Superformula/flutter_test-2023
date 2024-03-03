import 'package:flutter/material.dart';
import 'package:restaurantour/design_system/open_status_indicator.dart';
import 'package:restaurantour/design_system/restaurant_details.dart';
import 'package:restaurantour/design_system/restaurant_stars.dart';

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
          leading: imageUrl.isEmpty
              ? const SizedBox.shrink()
              : Image.network(
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
                  RestaurantStars(rating: rating),
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
