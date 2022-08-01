import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/restaurant_detail/cubit/restaurant_detail_cubit.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.select<RestaurantDetailCubit, bool>(
      (cubit) => cubit.state.isFavorite,
    );
    return IconButton(
      onPressed: () {
        context.read<RestaurantDetailCubit>().toggleFavorite();
      },
      icon: isFavorite
          ? const Icon(Icons.favorite)
          : const Icon(Icons.favorite_border),
    );
  }
}
