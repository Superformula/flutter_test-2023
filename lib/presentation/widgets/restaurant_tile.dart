import 'package:flutter/material.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/presentation/utils/style_util.dart';
import 'package:restaurantour/presentation/widgets/category_widget.dart';
import 'package:restaurantour/presentation/widgets/open_status_widget.dart';
import 'package:restaurantour/presentation/widgets/stars_widget.dart';

class RestaurantTile extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantTile({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/detail',
          arguments: restaurant,
        );
      },
      child: Container(
        constraints: const BoxConstraints(maxHeight: 104),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Hero(
              tag: restaurant.id!,
              child: Image.network(
                restaurant.heroImage,
                frameBuilder: (_, child, __, ___) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: child,
                  );
                },
                width: 88,
                height: 88,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 2),
                  Expanded(
                    child: Text(
                      restaurant.name!,
                      maxLines: 2,
                      style: StyleUtil.tileTitle,
                    ),
                  ),
                  const SizedBox(height: 4),
                  CategoryWidget(
                    category: restaurant.displayCategory,
                    price: restaurant.price,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      StarsWidget(rating: restaurant.rating!),
                      Expanded(child: Container()),
                      OpenStatusWidget(isOpen: restaurant.isOpen),
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
