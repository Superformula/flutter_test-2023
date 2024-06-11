import 'package:flutter/material.dart';
import 'package:restaurantour/core/design_system/text_styles/restaurantour_text_styles.dart';
import 'package:restaurantour/core/design_system/widgets/open_status_widget.dart';
import 'package:restaurantour/core/design_system/widgets/rating_widget.dart';
import 'package:restaurantour/features/restaurant/domain/models/restaurant.dart';

class RestaurantItemWidget extends StatelessWidget {
  const RestaurantItemWidget({required this.restaurant, Key? key})
      : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/restaurant_detail',
          arguments: restaurant,
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Hero(
                tag: restaurant.id ?? 'restaurant.heroImage',
                child: Image.network(
                  restaurant.heroImage,
                  width: 88,
                  height: 88,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name ?? '',
                    style: RestaurantourTextStyles.subtitle1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Text(
                    '${restaurant.price ?? ''} ${restaurant.displayCategory}',
                    style: RestaurantourTextStyles.caption,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        RatingWidget(rating: restaurant.rating ?? 0),
                        Expanded(child: Container()),
                        OpenStatus(isOpen: restaurant.isOpen),
                      ],
                    ),
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
