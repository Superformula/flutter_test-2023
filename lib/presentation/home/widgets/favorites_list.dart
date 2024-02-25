import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/presentation/app/state_management/favorites_cubit/favorites_cubit.dart';
import 'package:restaurantour/presentation/app/widgets/widgets.dart';
import 'package:restaurantour/presentation/home/widgets/widgets.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        final favoritesList = state.maybeWhen(
          loaded: (restaurants) => restaurants,
          orElse: () => [],
        );
        return favoritesList.isEmpty
            ? const EmptyScreen()
            : CustomScrollView(
                slivers: [
                  SliverList.builder(
                    itemCount: favoritesList.length,
                    itemBuilder: (context, index) {
                      return RestaurantItem(restaurant: favoritesList[index]);
                    },
                  ),
                ],
              );
      },
    );
  }
}
