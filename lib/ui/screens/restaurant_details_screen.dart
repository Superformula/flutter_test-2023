import 'package:flutter/material.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/ui/screens/widgets/widgets.dart';
import 'package:restaurantour/ui/theme/app_color.dart';
import 'package:restaurantour/ui/values/padding_values.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailsScreen({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final formattedAddress = restaurant.location?.formattedAddress;
    final reviews = restaurant.reviews;

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name ?? ''),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
          ),
        ],
      ),
      backgroundColor: AppColor.surface,
      body: ListView(
        children: [
          HeroNetworkImage(
            heroTag: restaurant.name,
            height: 362,
            width: 362,
            imageUrl: restaurant.heroImage,
          ),
          Padding(
            padding: const EdgeInsets.all(PaddingValues.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PriceCategory(
                      price: restaurant.price,
                      category: restaurant.displayCategory,
                    ),
                    IsOpen(isOpen: restaurant.isOpen),
                  ],
                ),
                const _DividerLine(),
                if (formattedAddress != null) ...[
                  Text('Address', style: textTheme.caption),
                  const SizedBox(height: PaddingValues.xl),
                  SizedBox(
                    width: 140,
                    child: Text(
                      formattedAddress,
                      style: textTheme.button!.copyWith(height: 2),
                    ),
                  ),
                  const _DividerLine(),
                ],
                if (restaurant.rating != null) ...[
                  Text('Overall Rating', style: textTheme.caption),
                  const SizedBox(height: PaddingValues.l),
                  _OverallRating(rating: restaurant.rating!),
                  const _DividerLine(),
                ],
                if (reviews != null && reviews.isNotEmpty) ...[
                  Text('${reviews.length} Reviews', style: textTheme.caption),
                  const SizedBox(height: PaddingValues.l),
                  for (final review in reviews) _ReviewListTile(review: review),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewListTile extends StatelessWidget {
  final Review review;

  static const defaultImage = 'https://picsum.photos/200';

  const _ReviewListTile({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...[
          if (review.rating != null)
            Padding(
              padding: const EdgeInsets.only(bottom: PaddingValues.medium),
              child: Rating(rating: review.rating!),
            ),
          if (review.text != null)
            Padding(
              padding: const EdgeInsets.only(bottom: PaddingValues.medium),
              child: Text(
                review.text!,
                style: textTheme.bodyText1,
              ),
            ),
          if (review.user != null)
            Row(
              children: [
                CircleAvatar(
                  radius: PaddingValues.xl,
                  backgroundImage:
                      NetworkImage(review.user!.imageUrl ?? defaultImage),
                ),
                const SizedBox(width: PaddingValues.medium),
                Expanded(
                  child: Text(
                    review.user!.name ?? '',
                    style: textTheme.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
        ],
        const _DividerLine(
          padding: EdgeInsets.symmetric(vertical: PaddingValues.l),
        ),
      ],
    );
  }
}

class _DividerLine extends StatelessWidget {
  final EdgeInsetsGeometry? padding;

  const _DividerLine({Key? key, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: PaddingValues.xl),
      child: const Divider(thickness: 1.5, height: 0),
    );
  }
}

class _OverallRating extends StatelessWidget {
  final double rating;

  const _OverallRating({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          rating.toString(),
          style: Theme.of(context).textTheme.headline4,
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: PaddingValues.extraSmall,
            bottom: PaddingValues.s,
          ),
          child:
              Icon(Icons.star, color: AppColor.star, size: PaddingValues.big),
        ),
      ],
    );
  }
}
