import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/localization/localization.dart';
import 'package:restaurantour/logic/logic.dart';
import 'package:restaurantour/pages/widgets/restaurants_list.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state.restaurants.isEmpty) {
          return Center(
            child: Text(
              context.l10n.noRestaurantsAddedYet,
            ),
          );
        }

        return RestaurantsList(restaurants: state.restaurants);
      },
    );
  }
}
