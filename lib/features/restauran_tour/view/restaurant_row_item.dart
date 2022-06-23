import 'package:flutter/material.dart';
import 'package:restaurantour/features/restauran_tour/model/restaurant.dart';
import 'package:restaurantour/widgets/image_tile.dart';
import 'package:restaurantour/widgets/open_status.dart';
import 'package:restaurantour/widgets/rating.dart';

class RestaurantRowItem extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback onTapItem;
  const RestaurantRowItem({
    Key? key,
    required this.restaurant,
    required this.onTapItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _thumbnail(context),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _nameWidget(context),
                      const SizedBox(height: 12),
                      _price(context),
                      const SizedBox(height: 12),
                      _ratingAndStatus(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _thumbnail(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Hero(
        tag: restaurant.heroImage,
        child: ImageTile(url: restaurant.heroImage),
      ),
    );
  }

  Widget _nameWidget(BuildContext context) {
    return Text(
      restaurant.name ?? "",
      style: Theme.of(context).textTheme.subtitle1,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _price(BuildContext context) {
    return Text(
      "${restaurant.price ?? ""} ${restaurant.categories?.first.title ?? ""}",
      style: Theme.of(context).textTheme.caption,
    );
  }

  Widget _ratingAndStatus(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Rating(restaurant.rating),
        OpenStatus(restaurant.isOpen),
      ],
    );
  }
}
