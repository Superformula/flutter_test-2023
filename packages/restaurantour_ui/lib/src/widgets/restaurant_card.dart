import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:restaurantour_ui/restaurantour_ui.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    Key? key,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.isOpenNow,
    required this.openText,
    required this.closedText,
    required this.defaultRestaurantName,
    required this.heroTag,
    this.onTap,
  }) : super(key: key);

  final String? title;
  final String? price;
  final String? category;
  final int? rating;
  final String? imageUrl;
  final bool isOpenNow;
  final String openText;
  final String closedText;
  final VoidCallback? onTap;
  final String defaultRestaurantName;
  final String heroTag;
  @override
  Widget build(BuildContext context) {
    const double cardHeight = 104.0;
    const double imageSize = 88.0;
    const double imageBorderRadius = 8.0;
    const int titleMaxLines = 2;
    const int defaultRating = 0;
    return InkWell(
      onTap: onTap,
      child: Card(
        child: SizedBox(
          width: double.infinity,
          height: cardHeight,
          child: Padding(
            padding: const EdgeInsets.all(RestaurantourPaddingValues.medium),
            child: Row(
              children: [
                Hero(
                  tag: heroTag,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(imageBorderRadius),
                    child: SizedBox(
                      width: imageSize,
                      height: imageSize,
                      child: imageUrl == null
                          ? const _ImagePlaceholder()
                          : CachedNetworkImage(
                              imageUrl: imageUrl!,
                              fit: BoxFit.cover,
                              placeholder: (_, __) => const _ImagePlaceholder(),
                              errorWidget: (_, __, ___) =>
                                  const Center(child: Icon(Icons.error)),
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: RestaurantourPaddingValues.big,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title ?? defaultRestaurantName,
                          maxLines: titleMaxLines,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: RestaurantourPaddingValues.s,
                        ),
                        child: Text(
                          '$price $category',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      Row(
                        children: [
                          Rating(rating: rating ?? defaultRating),
                          const Spacer(),
                          AttentionStatus(
                            text: isOpenNow ? openText : closedText,
                            iconColor: isOpenNow
                                ? RestaurantourColors.open
                                : RestaurantourColors.closed,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: RestaurantourColors.placeholder,
    );
  }
}
