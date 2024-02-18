import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurantour/app/interactor/models/restaurant.dart';
import 'package:restaurantour/app/ui/widgets/status_row.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final restaurantDescription = '${restaurant.price} ${restaurant.displayCategory}';

    final cachedNetworkImage = Hero(
      tag: restaurant.heroImage,
      child: CachedNetworkImage(
        imageUrl: restaurant.heroImage,
        imageBuilder: (context, imageProvider) => ClipRRect(
          borderRadius: BorderRadius.circular(8),
          clipBehavior: Clip.hardEdge,
          child: Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );

    final ratingBarIndicator = RatingBarIndicator(
      rating: restaurant.rating ?? 0,
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: Color(0xFFFFB800),
      ),
      itemCount: 5,
      itemSize: 20.0,
      direction: Axis.horizontal,
      unratedColor: Colors.transparent,
    );

    final bottomRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ratingBarIndicator,
        Hero(
          tag: 'isOpenNow${restaurant.isOpen}${restaurant.name}',
          child: StatusRow(isOpenNow: restaurant.isOpen),
        ),
      ],
    );

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 2,
      shadowColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            cachedNetworkImage,
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(restaurant.name ?? '', style: theme.textTheme.titleMedium, maxLines: 2),
                  const SizedBox(height: 8),
                  Text(restaurantDescription, style: theme.textTheme.labelSmall),
                  const SizedBox(height: 8),
                  bottomRow,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
