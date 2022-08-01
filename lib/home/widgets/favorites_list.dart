import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/l10n/l10n.dart';
import 'package:restaurantour/restaurant_detail/restaurant_detail.dart';

import 'package:restaurantour_ui/restaurantour_ui.dart';

import '../home.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final favoritesStatus = state.favoritesStatus;
        if (favoritesStatus == HomeListStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (favoritesStatus == HomeListStatus.error) {
          return const Center(
            child: Icon(Icons.error),
          );
        }
        final favorites = state.favorites;
        return ListView.separated(
          key: const Key('homeView_favoritesList'),
          itemCount: favorites.length,
          padding: const EdgeInsets.symmetric(
            horizontal: RestaurantourPaddingValues.big,
            vertical: RestaurantourPaddingValues.l,
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: RestaurantourPaddingValues.big,
          ),
          itemBuilder: (context, index) {
            final favorite = favorites[index];
            return RestaurantCard(
              title: favorite.name,
              category: favorite.category,
              imageUrl: favorite.photoUrl,
              rating: favorite.rating?.round(),
              price: favorite.price,
              isOpenNow: favorite.isOpenNow ?? false,
              openText: l10n.attentionStatusOpen,
              closedText: l10n.attentionStatusClosed,
              defaultRestaurantName: l10n.defaultRestaurantName,
              heroTag: favorite.id! + '_favorite_',
              onTap: () {
                Navigator.push(
                  context,
                  RestaurantDetailPage.route(favorite.id!),
                );
              },
            );
          },
        );
      },
    );
  }
}
