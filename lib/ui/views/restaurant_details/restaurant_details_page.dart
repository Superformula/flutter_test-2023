import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/blocs/blocs.dart';
import 'package:restaurantour/ui/models/restaurant_ui.dart';
import 'package:restaurantour/ui/theme/app_color.dart';
import 'package:restaurantour/ui/values/padding_values.dart';
import 'package:restaurantour/ui/widgets/widgets.dart';

import 'widgets/widgets.dart';

class RestaurantDetailsPage extends StatelessWidget {
  final RestaurantUi restaurantUi;

  const RestaurantDetailsPage({Key? key, required this.restaurantUi})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final restaurant = restaurantUi.restaurant;
    final formattedAddress = restaurant.location?.formattedAddress;
    final reviews = restaurant.reviews;

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name ?? ''),
        actions: [
          FavoriteButton(
            isFavorite: restaurantUi.isFavorite,
            onToggle: () => context
                .read<RestaurantsCubit>()
                .favoriteToggled(restaurantId: restaurant.id),
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
                const DividerLine(),
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
                  const DividerLine(),
                ],
                if (restaurant.rating != null) ...[
                  Text('Overall Rating', style: textTheme.caption),
                  const SizedBox(height: PaddingValues.l),
                  OverallRating(rating: restaurant.rating!),
                  const DividerLine(),
                ],
                if (reviews != null && reviews.isNotEmpty) ...[
                  Text('${reviews.length} Reviews', style: textTheme.caption),
                  const SizedBox(height: PaddingValues.l),
                  for (final review in reviews) ReviewListTile(review: review),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
