import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurantour/ui/screens/widgets/widgets.dart';
import 'package:restaurantour/ui/values/padding_values.dart';

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
          borderRadius: BorderRadius.circular(8),
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
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.fill,
                    width: 88,
                    height: 88,
                    placeholder: (_, __) => const SizedBox(
                      height: 8,
                      width: 8,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
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
                      Row(
                        children: [
                          if (price != null)
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: PaddingValues.s),
                              child: Text(price!),
                            ),
                          Text(category),
                        ],
                      ),
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
