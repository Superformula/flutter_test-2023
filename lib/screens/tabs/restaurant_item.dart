import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurantour/common/constants.dart';
import 'package:restaurantour/common/extensions.dart';
import 'package:restaurantour/models/restaurant.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem({
    super.key,
    required this.restaurant,
    required this.onTap,
  });

  final Restaurant restaurant;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      elevation: 4,
      shadowColor: Colors.grey.shade50,
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: restaurant.heroImage,
                imageBuilder: (context, imageProvider) => Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (_, __) => const SizedBox(
                  height: 80,
                  width: 80,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name ?? kEmptyString,
                      style: context.theme.textTheme.bodySmall?.copyWith(
                        fontSize: 20,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(restaurant.price ?? kEmptyString),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(restaurant.displayCategory),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: restaurant.rating ?? kZeroDouble,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          unratedColor: Colors.amber.withAlpha(50),
                          itemCount: 5,
                          itemSize: 20,
                          ignoreGestures: true,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Align(
                            child: Text(
                              restaurant.isOpen ? "Open Now" : "Closed",
                            ),
                            alignment: Alignment.centerRight,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Align(
                          child: Icon(
                            Icons.circle,
                            size: 14,
                            color: restaurant.isOpen
                                ? Colors.green.shade300
                                : Colors.red,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
