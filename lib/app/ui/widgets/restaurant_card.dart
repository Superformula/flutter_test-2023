import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RestaurantCard extends StatelessWidget {
  final String name;
  final List<String> foodCategories;
  final String priceRange;
  final double ratingStars;
  final bool isOpenNow;
  final String imageUrl;

  const RestaurantCard({
    Key? key,
    required this.name,
    required this.foodCategories,
    required this.priceRange,
    required this.ratingStars,
    required this.isOpenNow,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final categoriesString = foodCategories.length > 1
        ? '${foodCategories.sublist(0, foodCategories.length - 1).join(', ')} and ${foodCategories.last}'
        : foodCategories.first;
    final restaurantDescription = '$priceRange $categoriesString';

    final cachedNetworkImage = CachedNetworkImage(
      imageUrl: imageUrl,
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
    );

    final ratingBarIndicator = RatingBarIndicator(
      rating: ratingStars,
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
        _buildStatusRow(isOpenNow, theme),
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
                  Text(name, style: theme.textTheme.titleMedium, maxLines: 2),
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

Widget _buildStatusRow(bool isOpenNow, ThemeData theme) {
  final color = isOpenNow ? const Color(0xFF5CD313) : const Color(0xFFEA5E5E);
  final text = isOpenNow ? 'Open Now' : 'Closed';

  return Row(
    children: [
      Text(
        text,
        style: theme.textTheme.labelSmall?.copyWith(
          fontStyle: FontStyle.italic,
        ),
      ),
      const SizedBox(width: 4),
      Icon(Icons.circle, color: color, size: 16),
    ],
  );
}
