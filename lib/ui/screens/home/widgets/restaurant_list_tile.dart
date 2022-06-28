import 'package:flutter/material.dart';
import 'package:restaurantour/ui/values/values.dart';
import 'package:restaurantour/ui/widgets/widgets.dart';

class RestaurantListTile extends StatelessWidget {
  final String? title;
  final String category;
  final String image;
  final bool isOpen;
  final double? rating;
  final String? price;
  final VoidCallback onTap;

  const RestaurantListTile({
    Key? key,
    required this.title,
    required this.category,
    required this.image,
    required this.isOpen,
    required this.rating,
    required this.price,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.only(bottom: PaddingValues.big),
        child: PhysicalModel(
          color: theme.colorScheme.surface,
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(PaddingValues.medium),
          elevation: 2,
          child: Container(
            height: 104,
            padding: const EdgeInsets.all(PaddingValues.medium),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(PaddingValues.medium)),
                  ),
                  child: HeroNetworkImage(
                    imageUrl: image,
                    heroTag: title,
                    width: 88,
                    height: 88,
                  ),
                ),
                const SizedBox(width: PaddingValues.big),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null)
                        Text(
                          title!,
                          style: theme.textTheme.subtitle1,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      const Spacer(),
                      PriceCategory(category: category, price: price),
                      const SizedBox(height: PaddingValues.s),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Rating(rating: rating),
                          IsOpen(isOpen: isOpen),
                        ],
                      ),
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
}
