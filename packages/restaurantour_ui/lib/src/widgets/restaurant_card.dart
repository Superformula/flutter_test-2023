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
    required this.attentionStatusText,
    required this.attentionStatusIconColor,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final String price;
  final String category;
  final int rating;
  final String imageUrl;
  final String attentionStatusText;
  final Color attentionStatusIconColor;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    const double cardHeight = 104.0;
    const double imageSize = 88.0;
    const double imageBorderRadius = 8.0;
    const int titleMaxLines = 2;

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
                ClipRRect(
                  borderRadius: BorderRadius.circular(imageBorderRadius),
                  child: SizedBox(
                    width: imageSize,
                    height: imageSize,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        color: RestaurantourColors.placeholder,
                      ),
                      errorWidget: (_, __, ___) =>
                          const Center(child: Icon(Icons.error)),
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
                          title,
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
                          Raiting(rating: rating),
                          const Spacer(),
                          AttentionStatus(
                            text: attentionStatusText,
                            iconColor: attentionStatusIconColor,
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
