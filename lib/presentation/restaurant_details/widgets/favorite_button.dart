import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/presentation/app/helpers/helpers.dart';
import 'package:restaurantour/presentation/app/state_management/favorites_cubit/favorites_cubit.dart';
import 'package:restaurantour/presentation/restaurant_details/state_management/restaurant_details_cubit/restaurant_details_cubit.dart';
import 'package:restaurants_repository/restaurants_repository.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.theme;
    final colors = appTheme.colors;

    final restaurant = context.read<RestaurantDetailsCubit>().state.maybeWhen(
          loaded: (restaurant) => restaurant,
          orElse: () => const Restaurant(),
        );

    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        final isFavorite = context.read<FavoritesCubit>().isFavorite(
              id: restaurant.id,
            );
        return IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: colors.black,
          ),
          onPressed: () {
            isFavorite
                ? context
                    .read<FavoritesCubit>()
                    .removeFromFavorites(id: restaurant.id)
                : context
                    .read<FavoritesCubit>()
                    .addToFavorites(restaurant: restaurant);
          },
        );
      },
    );
  }
}
